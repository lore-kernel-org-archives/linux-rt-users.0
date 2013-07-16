From: "Jenisch Stefan" <Stefan.Jenisch@emco.at>
Subject: AW: RT thread status display?
Date: Tue, 16 Jul 2013 07:37:40 +0200
Message-ID: <AAFC45227224154C86D130E6B3CB4F360422BC3A@athafpm01.emco.at>
References: <3220ECFD-B7E4-4D2F-82F4-B4BE2C36EE4E@mah.priv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.emco.at ([194.107.90.51]:3268 "HELO mail.emco.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751341Ab3GPFxB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jul 2013 01:53:01 -0400
Content-class: urn:content-classes:message
In-Reply-To: <3220ECFD-B7E4-4D2F-82F4-B4BE2C36EE4E@mah.priv.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi folks,

=46ound a solution to this problem using:

#include <pthread.h>
int pthread_setname_np(pthread_t thread, const char *name);

Now I got custom thread names using top -H, htop (Using Option in "Setu=
p -> Display options -> show custom thread names") and ps -e -T.

Also see:

http://stackoverflow.com/questions/2369738/can-i-set-the-name-of-a-thre=
ad-in-pthreads-linux

Regards,
Stefan J.

-----Urspr=FCngliche Nachricht-----
Von: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owner@=
vger.kernel.org] Im Auftrag von Michael Haberler
Gesendet: Montag, 15. Juli 2013 15:59
An: linux-rt-users@vger.kernel.org
Betreff: RT thread status display?

we have an application with several RT threads within a single process =
- those show up nicely in say 'top -H'

how can a correlate a Posix thread id to the PID column in top? If noth=
ing else, we can do it via a log entry

Is there a way to pass a string which reappears in top/ps output (like =
a modifed argv or the like)? (threads are named in our application)


what I'm looking for is roughly the equivalent of this http://www.xenom=
ai.org/index.php//proc/xenomai/stat for rt-preempt

(in Xenomai the thread names are shown, so no need to correlate thread =
id's)

any better suggestions than ps/top?


thanks in advance

- Michael




--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in the body of a message to majordomo@vger.kernel.org More majordomo=
 info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
