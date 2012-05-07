From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: [PATCH 1/3] RFC: Solved unnecessary schedule latency in the TTY
 layer (1/3)
Date: Mon, 7 May 2012 16:10:15 +0200
Message-ID: <CAMSQXEEczyknnRaPhktaDj3e6GPCo6YpVFC-Nczk6uDpO6-ytA@mail.gmail.com>
References: <1336048663-21882-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ivo Sieben <meltedpianoman@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
	Alan Cox <alan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1336048663-21882-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

2012/5/3 Ivo Sieben <meltedpianoman@gmail.com>:
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -317,12 +317,7 @@ EXPORT_SYMBOL(tty_insert_flip_string_flags);
>
> =A0void tty_schedule_flip(struct tty_struct *tty)
> =A0{
> - =A0 =A0 =A0 unsigned long flags;
> - =A0 =A0 =A0 spin_lock_irqsave(&tty->buf.lock, flags);
> - =A0 =A0 =A0 if (tty->buf.tail !=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tty->buf.tail->commit =3D tty->buf.tail=
->used;
> - =A0 =A0 =A0 spin_unlock_irqrestore(&tty->buf.lock, flags);
> - =A0 =A0 =A0 schedule_work(&tty->buf.work);
> + =A0 =A0 =A0 tty_flip_buffer_push(tty);
> =A0}
> =A0EXPORT_SYMBOL(tty_schedule_flip);
>

I have an additional question on the above change in the patch that I'v=
e send:

I found that two functions in drivers/tty/tty_buffer.c implement
almost the same functionality:
- tty_schedule_flip
- tty_flip_buffer_push

Only difference was that tty_schedule_flip() always uses the work
queue, while the tty_flip_buffer_push only uses the work queue in case
of a non prempt_rt system and low_latency flag unset.

But is my change correct? I see that most serial drivers use the
tty_flip_buffer_push() function. But still a number of drivers use the
tty_schedule_flip() function. I even found one driver that uses both
(drivers/staging/serqt_usb2/serqt_usb2.c). Does my patch introduce
bugs to these drivers? Or is the tty_schedule_flip() a legacy
function, and would it be better to remove it completely?

Regards,
Ivo Sieben
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
