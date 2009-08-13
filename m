From: John Kacur <jkacur@gmail.com>
Subject: Re: [PATCH][RT] pty low latency
Date: Thu, 13 Aug 2009 13:35:50 +0200
Message-ID: <520f0cf10908130435t2aba0d23mb1465daef3a4a997@mail.gmail.com>
References: <1250138537.15796.18.camel@quadrophenia.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Sven-Thorsten Dietrich <sdietrich@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753246AbZHMLn0@vger.kernel.org>
In-Reply-To: <1250138537.15796.18.camel@quadrophenia.thebigcorporation.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Aug 13, 2009 at 6:42 AM, Sven-Thorsten
Dietrich<sdietrich@novell.com> wrote:
>
> Subject: add hunks dropped in rt 2.6.31-rc5-rt1.1 forward port
> From: patch-2.6.31-rc4-rt1
> Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>
> --- a/drivers/char/pty.c
> +++ b/drivers/char/pty.c
> @@ -52,6 +52,7 @@ static void pty_close(struct tty_struct *tty, struc=
t file *filp)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0tty->link->packet =3D 0;
> =A0 =A0 =A0 =A0set_bit(TTY_OTHER_CLOSED, &tty->link->flags);
> + =A0 =A0 =A0 tty_flip_buffer_push(tty->link);
> =A0 =A0 =A0 =A0wake_up_interruptible(&tty->link->read_wait);
> =A0 =A0 =A0 =A0wake_up_interruptible(&tty->link->write_wait);
> =A0 =A0 =A0 =A0if (tty->driver->subtype =3D=3D PTY_TYPE_MASTER) {
> @@ -207,6 +208,7 @@ static int pty_open(struct tty_struct *tty, struc=
t file *filp)
> =A0 =A0 =A0 =A0clear_bit(TTY_OTHER_CLOSED, &tty->link->flags);
> =A0 =A0 =A0 =A0set_bit(TTY_THROTTLED, &tty->flags);
> =A0 =A0 =A0 =A0retval =3D 0;
> + =A0 =A0 =A0 tty->low_latency =3D 1;
> =A0out:
> =A0 =A0 =A0 =A0return retval;
> =A0}
>

Thank You - I applied this.
