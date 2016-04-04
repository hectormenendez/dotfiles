#! /usr/env node
'use strict';

const PATH = require('path');
const QS   = require('querystring');
const EXE = require('child_process').exec;

const Rx = require('../private/node_modules/rxjs/Rx');
const Util = require('/Users/etor/Source/github.gikmx/util');

let github = 'https://github.com';

// The pathnames involved in this operation (these should be centralized)
let path = Util.object.set({
    home      : process.env.HOME,
    dotfiles  : process.env.DOTFILES_ROOT,
    font      : self => PATH.join(self.dotfiles, 'private', 'fonts'),
    os        : self => PATH.join(self.home, 'Library', 'Fonts'),
});

// The list of fonts to download
let fonts = [
    {
        name: 'UbuntuMono',
        path: self => PATH.join(path.font, self.name),
        repo: (self, set) => set('%s/powerline/fonts/blob/2015-12-04/%s', github, self.name),
        type: 'Ubuntu Mono derivative Powerline',
        ext : 'ttf',
        list: [
            (self, set) => set('%s.%s'             , self.type , self.ext) ,
            (self, set) => set('%s Italic.%s'      , self.type , self.ext) ,
            (self, set) => set('%s Bold.%s'        , self.type , self.ext) ,
            (self, set) => set('%s Bold Italic.%s' , self.type , self.ext) ,
        ]
    },
    {
        name: 'glyph-source-fonts',
        path: self => PATH.join(path.font, self.name),
        repo: (self, set) => set('%s/ryanoasis/nerd-fonts/blob/v0.6.1/%s', github, self.name),
        list: [
            'FontAwesome.otf',
            'Pomicons.otf',
            'PowerlineExtraSymbols.otf',
            'PowerlineSymbols.otf',
            'devicons.ttf',
            'octicons.ttf',
            'original-source.otf'
        ]
    },
].map(Util.object.set);

let cmds$ = Rx.Observable
    // Convert font list into an observable, and define its logic.
    .from(fonts)
    // a) iterates each block of fonts and returns an array of commands for it
    // b) flattens the array one level, so now it's a command string for each font.
    .mergeMap(font =>
        font.list.map(filename =>
            Util.object.set({
                filename : filename,
                repo     : font.repo,
                path     : font.path,
                cmds     :  [
                    // Create the directory, yeah, on each iteration.
                    self => `mkdir -p "${self.path}"`,
                    // Fetch the font using curl
                    (self, set) => set(
                        'curl -fLo "%s" "%s?raw=true"',
                        PATH.join(self.path, self.filename),
                        [self.repo, encodeURIComponent(self.filename)].join('/')
                    ),
                    // Copy font into system folder for activation
                    (self, set) => set(
                        'cp "%s" "%s"',
                        PATH.join(self.path, self.filename),
                        PATH.join(path.os, self.filename)
                    ),
                    // Let the user know that is all done.
                    self => `echo "Installed: «${PATH.basename(self.filename)}»"`,
                ],
            }).cmds.join(' && ') // TODO: Run each cmd separatedly instead?
        )
    )
    // Execute stream of commands in parallel (😎 )
    .mergeMap(cmd => Rx.Observable.bindNodeCallback(EXE)(cmd));


// Deal with the response.
// You could process this stream along with others you make.
cmds$.subscribe(
    response => {
        process.stdout.write(response.concat(['\n']).reverse().join('\n'));
    },
    error    => console.error('ERROR:', error.message),
    ()       => console.log('\nAll fonts installed successfully.\n')
);
