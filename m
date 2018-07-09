Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41857 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754077AbeGIJzM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Jul 2018 05:55:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17-v6so8825166ljy.8
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Jul 2018 02:55:11 -0700 (PDT)
From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: tty latency and RT
References: <681500CE65202E47A192754B01DAB4673BE3D87A37@SDE12.beckipc.net>
        <87muv4zpu8.fsf@linutronix.de>
Date: Mon, 09 Jul 2018 11:55:08 +0200
In-Reply-To: <87muv4zpu8.fsf@linutronix.de> (John Ogness's message of "Fri, 06
        Jul 2018 11:16:31 +0200")
Message-ID: <87pnzwag3n.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: =?utf-8?Q?Andr=C3=A9?= Pribil <a.pribil@beck-ipc.com>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

John Ogness <john.ogness@linutronix.de> writes:

> Hi,
>
> On 2018-07-06, Andr=C3=A9 Pribil <a.pribil@beck-ipc.com> wrote:
>> are there any plans to improve the latency with serial ttys and RT?
>>
>> I'm seeing very high latencies (up to 100 ms) when a high priority=20
>> RT thread accesses a serial tty port. I'm working with 4.14.52-rt34=20
>> on a ARM system.
>
> As you later point out, this is a problem with the tty subsystem
> (kworker) and is not RT-specific. This problem needs to be fixed in
> mainline.
>
>> The reason for this issue seems to be that a kworker thread with a=20
>> normal priority is involved here. When the high priority RT=20
>> thread needs to wait for this kworker thread, it can easily be blocked=20
>> by other lower priority RT threads running in the system.
>>
>> I have seen that Steven Walter proposed some change in 2015, where
>> this kworker thread in replaced by a kthread with a RT priority if
>> the low_latency mode is selected.
>> See: https://www.spinics.net/lists/linux-serial/msg17782.html
>>
>> The follow-up discussion in this thread also proposes a solution that
>> allows low_latency ports to directly execute the worker.
>> As interrupts are already threaded in PREEMPT_RT, wouldn't that be a=20
>> solution?
>
> The patches and discussions in that thread provide some good ground work
> for a real solution. Someone needs to take more time to work with the
> maintainers to get it mainline.

I am using the following patch.
Not sure if it is worth proposing it for mainline inclusion, though.
RFC:

commit ca633caa8a18e8043f7f59cf9b3b9cbe2097a5ee
Author: Esben Haabendal <eha@deif.com>
Date:   Fri Jun 1 13:03:41 2018 +0200

    tty: Re-introduce annoying historical pain in the butt
=20=20=20=20
    Since a9c3f68f3cd8d55f809fbdb0c138ed061ea1bd25, use of UART for real-ti=
me
    applications has been problematic.
=20=20=20=20
    When all CPU cores are running SCHED_FIFO tasks, tty buffers will be
    stalled, causing unbounded latency of UART RX.  For applications with
    real-time requirements to reaction UART RX, this is of-course unaccepta=
ble.
=20=20=20=20
    This change reuses the old low_latency flag, but only respects it for
    drivers using threaded interrupt handler.  Applications caring about
    real-time requirements should do that anyway.
=20=20=20=20
    Signed-off-by: Esben Haabendal <eha@deif.com>

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index f8eba1c5412f..eb9ad23341c1 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -399,6 +399,7 @@ EXPORT_SYMBOL(__tty_insert_flip_char);
 void tty_schedule_flip(struct tty_port *port)
 {
 	struct tty_bufhead *buf =3D &port->buf;
+	WARN_ON(port->low_latency);
=20
 	/* paired w/ acquire in flush_to_ldisc(); ensures
 	 * flush_to_ldisc() sees buffer data.
@@ -408,6 +409,16 @@ void tty_schedule_flip(struct tty_port *port)
 }
 EXPORT_SYMBOL(tty_schedule_flip);
=20
+static void flush_to_ldisc(struct work_struct *work);
+
+void tty_do_flip(struct tty_port *port)
+{
+	struct tty_bufhead *buf =3D &port->buf;
+	smp_store_release(&buf->tail->commit, buf->tail->used);
+	flush_to_ldisc(&buf->work);
+}
+EXPORT_SYMBOL(tty_do_flip);
+
 /**
  *	tty_prepare_flip_string		-	make room for characters
  *	@port: tty port
@@ -543,7 +554,18 @@ static void flush_to_ldisc(struct work_struct *work)
=20
 void tty_flip_buffer_push(struct tty_port *port)
 {
-	tty_schedule_flip(port);
+	if (in_interrupt() || !port->low_latency)
+		/* Schedule buffer flip on workqueue if running in hardirq
+		   context, or if low_latency mode is not enabled.
+		*/
+		tty_schedule_flip(port);
+	else
+		/* Flip buffer immediately when when low_latency flag is set
+		   and running in threaded interrupt handler.  Without this,
+		   latency can increase dramatically when one or more
+		   SCHED_FIFO tasks are hogging the CPU(s).
+		*/
+		tty_do_flip(port);
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
=20
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 767f62086bd9..005443e83b2d 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -13,6 +13,7 @@ extern int tty_prepare_flip_string(struct tty_port *port,
 		unsigned char **chars, size_t size);
 extern void tty_flip_buffer_push(struct tty_port *port);
 void tty_schedule_flip(struct tty_port *port);
+void tty_do_flip(struct tty_port *port);
 int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char f=
lag);
=20
 static inline int tty_insert_flip_char(struct tty_port *port,
