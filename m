From: Sujit K M <sjt.kar@gmail.com>
Subject: Re: Looking for a real time IPC to be used with select
Date: Sun, 18 Apr 2010 10:13:25 +0530
Message-ID: <h2v921ca19c1004172143qbd48d15axe1ba6c2a9f6a35fd@mail.gmail.com>
References: <3215024.1271427173625.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:48817 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab0DREn1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 18 Apr 2010 00:43:27 -0400
Received: by qyk34 with SMTP id 34so4727161qyk.22
        for <linux-rt-users@vger.kernel.org>; Sat, 17 Apr 2010 21:43:26 -0700 (PDT)
In-Reply-To: <3215024.1271427173625.JavaMail.ngmail@webmail08.arcor-online.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> I have a real time application with a couple of threads.
> One thread is waiting on a select() call (with timeout)
> for data coming in from a UDP Ethernet socket.
> Once it gets data it does some computation and finally
> leads to the writing of data on the UDP socket.
>
> The (simplified) code for this real time thread is:
>
> void *thread_func_A(void *arg)
> {
> =A0while (1)
> =A0{
> =A0 =A0 rc =3D select(...); // Read socket with timeout_value);
> =A0 =A0 if (rc > 0)
> =A0 =A0 {
> =A0 =A0 =A0 =A0recv(.., data, .. ); // recv data from socket
> =A0 =A0 =A0 =A0compute(data, data2); =A0 =A0 =A0 // Compute data and =
modify them to data2
> =A0 =A0 =A0 =A0send(..., data2, ...); // Send data2 to socket
> =A0 =A0 }
> =A0 }
> }
>
> This works fine.
>
> Now I have the need that another real time thread B should also be ab=
le
> to trigger the "select()" in the thread_func_A() above.

You mean you want to timeout the thread_func_A() Select.

=46rom the Select Man Page as Quoted Below(http://linux.die.net/man/2/s=
elect)

(iii)

select() has no sigmask argument, and behaves as pselect() called with
NULL sigmask.

Three independent sets of file descriptors are watched. Those listed
in readfds will be watched to see if characters become available for
reading (more precisely, to see if a read will not block; in
particular, a file descriptor is also ready on end-of-file), those in
writefds will be watched to see if a write will not block, and those
in exceptfds will be watched for exceptions. On exit, the sets are
modified in place to indicate which file descriptors actually changed
status. Each of the three file descriptor sets may be specified as
NULL if no file descriptors are to be watched for the corresponding
class of events.

> This means, I should add a suitable inter-process-communication
> between thread A and B that can be used with select() as well.
> Having this, the thread A can be triggered by the socket or
> by the IPC from thread B by adding two file desciptors to the readfds
> of select().

This might be helpfull as said above.

> My question is now: What kind of IPC is preferred here?
> The only IPC I see is a local socket communication, however
> this looks like a huge overhead for triggering...

I think it is quite possible to use the regular IPC Data structures on =
Linux.

> Both, threads A and B are real time threads, thus any IPC in use
> should be supported by the RT_PREEMPT patch.

Not quite sure what you mean by this. The RT_PREEMPT Patch Does change
according to the IPC or the Related RT Functions.

>
> Setup: PC (Core2Quad, kernel 2.6.31.2-rt13)
>
> Thanks for any feedback on this question.
>
> Regards
>
> Mathias
>
>
>
> --
> Mathias Koehrer
> mathias_koehrer@arcor.de
>
>
> Traumziele - von Beschreibung bis Buchung jetzt kompakt auf den Reise=
-Seiten von Arcor.de! http://www.arcor.de/rd/footer.reise
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
-- Sujit K M

blog(http://kmsujit.blogspot.com/)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
