From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: 2.6.33.9-rt31 boot problem
Date: Wed, 15 Jun 2011 10:48:10 -0700
Message-ID: <4DF8F05A.6050203@localhost>
References: <BANLkTiknsZhD2XHYoW4x2M8RfDku8righg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: dashesy <dashesy@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4.Stanford.EDU ([171.67.219.84]:42327 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751958Ab1FORyI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Jun 2011 13:54:08 -0400
In-Reply-To: <BANLkTiknsZhD2XHYoW4x2M8RfDku8righg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/12/2011 09:21 AM, dashesy wrote:
> First, sorry for double post, I did not know if my email went through
> first time (maybe for large config file attached)
>
> Same machine 2.6.33.7.2-rt30 boots fine with Ubuntu and no problem at
> all, today I tried the new version with Fedora 15 but it crashes early
> in the boot process.

A workaround in Fedora 15 (posted in another message to another list so 
you may not have seen it) is to use upstart instead of systemd for 
startup (systemd requires features only found on newer kernels).

In the kernel boot line add "init=/sbin/upstart" and of course make sure 
you have the upstart package installed.

BTW, thanks for the patch!
-- Fernando


> I have attached boot log I get from Qemu which is
> the same (apart from the CPU number for example). I also have attached
> the patch needed for successful build; V4l example in the
> documentation was removed (did not compile with new API), also some
> gcc4.6 related issues with anonymous union and superfluous warnings
> during build was resolved. The patch is just to have the build so it
> is not fully documented.
> Please let me know if any further information is needed, if I should
> submit the crash to another mailing list, or if I should enable some
> option in the config file for more elaborate crash log. Since crash is
> very early I could not get a crashdump.
>
> I will be happy to look into the source code too (I am learning), if
> you can give me some hint, thanks
>
> dashesy
