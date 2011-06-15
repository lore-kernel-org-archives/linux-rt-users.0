From: dashesy <dashesy@gmail.com>
Subject: Re: 2.6.33.9-rt31 boot problem
Date: Wed, 15 Jun 2011 13:18:01 -0600
Message-ID: <BANLkTikywL79BpXj44Ve24SbmwB1Wr1Ckg@mail.gmail.com>
References: <BANLkTiknsZhD2XHYoW4x2M8RfDku8righg@mail.gmail.com>
	<4DF8F05A.6050203@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64740 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab1FOTSC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Jun 2011 15:18:02 -0400
Received: by bwz15 with SMTP id 15so732484bwz.19
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jun 2011 12:18:01 -0700 (PDT)
In-Reply-To: <4DF8F05A.6050203@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jun 15, 2011 at 11:48 AM, Fernando Lopez-Lezcano
<nando@ccrma.stanford.edu> wrote:
> On 06/12/2011 09:21 AM, dashesy wrote:
>>
>> First, sorry for double post, I did not know if my email went through
>> first time (maybe for large config file attached)
>>
>> Same machine 2.6.33.7.2-rt30 boots fine with Ubuntu and no problem at
>> all, today I tried the new version with Fedora 15 but it crashes early
>> in the boot process.
>
> A workaround in Fedora 15 (posted in another message to another list so you
> may not have seen it) is to use upstart instead of systemd for startup
> (systemd requires features only found on newer kernels).
>
> In the kernel boot line add "init=/sbin/upstart" and of course make sure you
> have the upstart package installed.

Thanks for the reply,
Actually oops is much earlier than init, as you can see in the
attached boot.log I have "init=/bin/sh"
[    0.000000] Linux version 2.6.33.9-rt31 (ehsan@ehsan) (gcc version
4.6.0 20110530 (Red Hat 4.6.0-9) (GCC) ) #3 SMP PREEMPT RT Wed Jun 8
16:16:46 MDT 2011

[    0.000000] Command line: console=ttyS0 root=/dev/sda rw init=/bin/sh

>
> BTW, thanks for the patch!
> -- Fernando
>
>
>> I have attached boot log I get from Qemu which is
>> the same (apart from the CPU number for example). I also have attached
>> the patch needed for successful build; V4l example in the
>> documentation was removed (did not compile with new API), also some
>> gcc4.6 related issues with anonymous union and superfluous warnings
>> during build was resolved. The patch is just to have the build so it
>> is not fully documented.
>> Please let me know if any further information is needed, if I should
>> submit the crash to another mailing list, or if I should enable some
>> option in the config file for more elaborate crash log. Since crash is
>> very early I could not get a crashdump.
>>
>> I will be happy to look into the source code too (I am learning), if
>> you can give me some hint, thanks
>>
>> dashesy
>

dashesy
