From: Dorian VEGARA <dorian.vegara@gmail.com>
Subject: Re: Cannot boot RTLinux
Date: Sun, 25 Jan 2015 21:19:12 +0100
Message-ID: <CAOQDsMwN5iT4PfG=YDKLxEOd8p4ms_V=OAXXNM=q2HeCY9ehsQ@mail.gmail.com>
References: <CAOQDsMw6H_eQg9-kVCi2HVxO9-Di4es82VW_Wm2K4OqfM_9N_A@mail.gmail.com>
	<20150123082852.37d5dfe3@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt users <linux-rt-users@vger.kernel.org>
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:64860 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727AbbAYUTO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Jan 2015 15:19:14 -0500
Received: by mail-lb0-f169.google.com with SMTP id f15so4839346lbj.0
        for <linux-rt-users@vger.kernel.org>; Sun, 25 Jan 2015 12:19:13 -0800 (PST)
In-Reply-To: <20150123082852.37d5dfe3@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Ralf, you was right : I typed the root=UUID=[...] and the initrd line
in the GRUB2 config file and now, I can boot RTLinux.

However, another problem appeared. I believe mouse and keyboard are
not recognized.

In fact, when RTLinux is booted :
1. First, the graphical display is shown. There is nothing, except the
same desktop-background-image than my OpenSUZE's one. Even the mouse's
cursor isn't shown.
2. Secondly, after I typed CTRL+ALT+F10, the command line display
appears. That's OK. But there is a problem... : I can't do nothing.
When I type something with my keyboard, nothing appears in the
console. For example, if I type the letter 'a', then it won't be
printed in the console.

So : do you think the mouse and the keyboard aren't recognized by the kernel ?

Thanks a lot,
Best regards

2015-01-23 8:28 GMT+01:00 Ralf Mardorf <ralf.mardorf@alice-dsl.net>:
> On Thu, 22 Jan 2015 20:39:34 +0100, Dorian VEGARA wrote:
>> The GRUB2 configuration is OK.
>
> Are you sure?
> Isn't there missing something similar too
> linux   /boot/foo root=UUID=1234 ro
>                   ^^^^^^^^^^^^^^^^^
> initrd  /boot/init*-foo
> ^^^^^^^^^^^^^^^^^^^^^^^
> ?
>
>> http://nsa33.casimages.com/img/2015/01/22/150122084114722488.jpg
>> https://drive.google.com/file/d/0BxBRiO4INcfxWnltOFZDeDNBZmM/view?usp=sharing
>
> I didn't read all the screenshots, consider to post ASCII log files
> instead of photos and the output of
>> uname -a
> Does it include PREEMPT RT?
>
> You can quasi chroot in by
>
> # systemd-nspawn -D /mnt/point/of/your/suse
>
> to get ASCII output of the odd binary journalctl files and uname.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
