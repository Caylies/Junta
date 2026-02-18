import tkinter

import sv_ttk

from app import Application

if __name__ == "__main__":
    root = tkinter.Tk()
    root.title("Junta Editor")

    application = Application(root)
    application.build()

    sv_ttk.set_theme("dark")
    root.mainloop()
