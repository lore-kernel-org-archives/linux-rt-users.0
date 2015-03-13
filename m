From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Kenrel panic with 3.18.7-rt2 - Was: Kenrel panic with 3.18.7-rt2
 - rootfs at MMC
Date: Fri, 13 Mar 2015 10:26:39 -0400
Message-ID: <CAP=VYLofi0bYu5Lk+cnxyZ3upv2xueDDvHbO9B4Q8CgxpL0CGA@mail.gmail.com>
References: <20150306174336.2eb1fea9@archlinux> <20150306174700.29fc83bf@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:41211 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbbCMO1L (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Mar 2015 10:27:11 -0400
Received: by wghl2 with SMTP id l2so23647517wgh.8
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Mar 2015 07:27:09 -0700 (PDT)
In-Reply-To: <20150306174700.29fc83bf@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Mar 6, 2015 at 11:47 AM, Ralf Mardorf
<ralf.mardorf@alice-dsl.net> wrote:
> On Fri, 6 Mar 2015 17:43:36 +0100, Ralf Mardorf wrote:
>>On Fri, 6 Mar 2015 13:24:41 +0100, Sebastian Andrzej Siewior wrote:
>>>if the system is still responsible you could "dmesg > file" and then
>>>that file would interresting as long as there is no systemd crap in
>>>it.
>>
>>That's the problem, the system isn't responsive anymore. There also is
>>no file /var/log/dmesg. I can reboot and run the dmesg command, but it
>>only shows the messages for the last boot.
>>I guess I'm a power user regarding several Linux things, but I'm
>>completely lost regarding some issues, since several distros switched
>>to systemd.

So I just did a quick test with 3.18.9-rt on an athlon x4 64 bit.
Did "make localyesconfig" - ensured RT_FULL was on and that
booted OK without any triple fault or similar.  So unless you can
capture some of the log with a camera or a serial port, it is hard
for us to help figure out what the problem is.

Paul.
--

>
> Sorry, I didn't keep the thread as wanted, but forgot to change the
> subject. Fixed ;).
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
