From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: [4.1.7-rt8][report] Very high cyclictest latency during glmark2
 on i915 gpu
Date: Wed, 14 Oct 2015 10:42:56 +0200
Message-ID: <CALqGcGrOe-=VS-tXvJW0bCdmcLgpkYWh9thXyuHxWxypeFTNTA@mail.gmail.com>
References: <CALqGcGpLJ+x_Gg7i4W4UCe4+GJEfdFNo-UryyOyQZJ1q5AAWJQ@mail.gmail.com>
	<561E0970.8050007@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Matthias Meier <matthias.j.meier@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35246 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbbJNIm6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Oct 2015 04:42:58 -0400
Received: by lbwr8 with SMTP id r8so40808499lbw.2
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Oct 2015 01:42:57 -0700 (PDT)
In-Reply-To: <561E0970.8050007@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 14, 2015 at 9:51 AM, Matthias Meier
<matthias.j.meier@gmx.net> wrote:
> is there a high interrupt rate on '/proc/interrupts' during glmark2 running
> compared to the other kernels?

I checked the interrupt for i915 on 3.12 and 4.1. After a complete
glmark2 run on a freshly booted system I have a lot less interrupts on
4.1 than on 3.12.

3.12: 1'794843 irqs
4.1: 950'367 irqs

Christoph
