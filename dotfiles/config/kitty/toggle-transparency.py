from kitty.boss import Boss

def main(args: list[str]) -> str:
    pass

from kittens.tui.handler import result_handler
@result_handler(no_ui=True)

def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    import kitty.fast_data_types as f

    os_window_id = f.current_focused_os_window_id()
    current_opacity = f.background_opacity_of(os_window_id)

    print(current_opacity)
    if (current_opacity != 1.0):
        boss.set_background_opacity("1.0")
    else:
        boss.set_background_opacity("0.95")


