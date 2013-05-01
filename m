From: Dmitry Lysenko <dvl36.ripe.nick@gmail.com>
Subject: Re: [ANNOUNCE] 3.2.44-rt64
Date: Wed, 01 May 2013 12:17:15 +0300
Message-ID: <5180DD9B.5070509@gmail.com>
References: <1367378464.30667.73.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:55068 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758751Ab3EAJRU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 May 2013 05:17:20 -0400
Received: by mail-ee0-f48.google.com with SMTP id d49so613820eek.21
        for <linux-rt-users@vger.kernel.org>; Wed, 01 May 2013 02:17:18 -0700 (PDT)
In-Reply-To: <1367378464.30667.73.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,
There is typo. Beginning from 3.2.38-rt58 patch.

At rcutiny_plugin.h:

static void invoke_rcu_callbacks(void)
{
         have_rcu_kthread_work = 1;
         swake_up(&rcu_kthread_wq);
         ~~~~~~~~
}

swake_up does not exist in 3.2.x-rt kernel tree.

Already reported ( 
http://www.spinics.net/lists/linux-rt-users/msg09774.html ),
but still exists.

Regards,
   Dmirty.

On 05/01/2013 06:21 AM, Steven Rostedt wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 3.2.44-rt64 stable release.
>
>
> This release is just an update to the new stable 3.2.44 version
> and no RT specific changes have been made.
>
>
> You can get this release via the git tree at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>    branch: v3.2-rt
>    Head SHA1: b1780bf6f0043f07108b9e2acbe8c4e7453ec6c5
>
>
> Or to build 3.2.44-rt64 directly, the following patches should be applied:
>
>    http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz
>
>    http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.44.xz
>
>    http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.44-rt64.patch.xz
>
>
>
>
> Enjoy,
>
> -- Steve
>

