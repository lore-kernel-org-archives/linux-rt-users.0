From: Tony Godshall <togo@of.net>
Subject: Re: RT-linux on MIPS..
Date: Tue, 9 Jun 2009 14:53:03 -0700
Message-ID: <3424dc900906091453h658c1f7cicfd5893251d13be3@mail.gmail.com>
References: <74848fb40906090018m267594f7u6225cf77388f8b4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tom Desouza <desouza.tom@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:43071 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbZFIVxF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Jun 2009 17:53:05 -0400
Received: by ewy6 with SMTP id 6so372389ewy.37
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Jun 2009 14:53:04 -0700 (PDT)
In-Reply-To: <74848fb40906090018m267594f7u6225cf77388f8b4c@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Let me scroogle that for you...

So there is activity back in the early ought's through 2.6.24 fairly re=
cently

1. TimeSys to port Linux/RT to MIPS

      "News, views, articles, and discussion on using Linux in mobile
and embedded devices."
      www.linuxdevices.com/news/NS6948507242.html

2. Lineo contributes MIPS port to RTAI real-time Linux add-on

      "24 Jan 2002 ... News, views, articles, and discussion on using
Linux in mobile and embedded devices."
      www.linuxdevices.com/news/NS6193204523.html

3. 2.6.24-rc2-rt1: msg#00081 linux.rt.user

      "rostedt@gandalf:~/linux-2.6.24-rc2$ tar -xf
patch-2.6.24-rc2-rt1-broken-out.tar. bz2
rostedt@gandalf:~/linux-2.6.24-rc2$ quilt push preempt-realtime-mips.
=2E.."
      osdir.com/ml/linux.rt.user/2007-11/msg00081.html


By the way, this list should not be confused with the proprietary
technology now owned by Wind River

2. RTLinux - Wikipedia, the free encyclopedia

      "15 Apr 2009 ... RTLinux or RTCore (or Real-Time Linux) is a
hard realtime RTOS microkernel that runs the entire Linux operating
system as a fully ..."
      en.wikipedia.org/wiki/RTLinux


Best Regards.



On Tue, Jun 9, 2009 at 12:18 AM, Tom Desouza<desouza.tom@gmail.com> wro=
te:
> Hi all,
>
> Can anyone have tried rt-patches on MIPS architecture ? Is RT-linux w=
orks
> on MIPS architecture with all features support i.e. PREEMPT_HARDIRQS,
> PREEMPT_SOFTIRQ, PREEMPT_RCU?
>
> Thanks,
> Tom
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
