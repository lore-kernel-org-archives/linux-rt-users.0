From: Nick Lott <nick.lott@gmail.com>
Subject: Re: Preempt-rt on 3.2.23 raspberry pi kernel
Date: Mon, 30 Jul 2012 06:37:33 +0100
Message-ID: <2362932D-3DC3-460A-8F3C-C471A8577FBA@gmail.com>
References: <op.wh4l2os2k9j7wf@soja-mo> <op.wh75q4qvk9j7wf@soja-mo> <op.wh75zuz8k9j7wf@soja-mo>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: jan.sommer@s2008.tu-chemnitz.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60738 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab2G3Fhh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2012 01:37:37 -0400
Received: by wibhr14 with SMTP id hr14so1463667wib.1
        for <linux-rt-users@vger.kernel.org>; Sun, 29 Jul 2012 22:37:36 -0700 (PDT)
In-Reply-To: <op.wh75zuz8k9j7wf@soja-mo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have a complete kernel log of the same problem but on 3.16 with rt27.

http://www.raspberrypi.org/phpBB3/viewtopic.php?f=29&t=9311

I've not had time to go any further with this or update and test with a newer kerenel.

Hope this helps.

Nick Lott
http://www.brokentoaster.com/

On 29 Jul 2012, at 9:32PM, Jan Sommer wrote:

> Hello,
> 
> This probably is related to the this thread
> http://comments.gmane.org/gmane.linux.rt.user/8424 but I don't know how to
> answer to it as I have just subscribed to the mailinglist.
> As Tom I used the 3.2.23 branch for the raspberry pi from bootc
> (http://www.bootc.net/projects/raspberry-pi-kernel/) and applied the
> rt-patch. Because Tom told about problems with the USB-driver I set up my
> system to mount the rootfs via NFS.
> The patched kernel boots up fine when using the voluntary, low latency and
> basic preempt option but fails to boot after compiling it with the
> preempt_full option.
> You can find a screenshot (literally ;-) ) of the last kernel
> output here: http://imageshack.us/photo/my-images/140/rpikernellog.jpg/
> 
> It complains about a certain part of the code within rtmutex.c.
> 
> As I'm fairly new to building kernel related things, does anyone has a
> suggestion what to do? The problem occurs in both versions of the patch
> (rt36 and rt37) and it does not matter if I want to mount the rootfs via
> sd-card or NFS (probably because the error appears even before).
> At the moment I don't have the chance to hook up a serial cable to the
> serial port as I don't have level converters.
> 
> 
> Best regards,
> 
>       Jan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

