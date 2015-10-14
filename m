From: Matthias Meier <matthias.j.meier@gmx.net>
Subject: Re: [4.1.7-rt8][report] Very high cyclictest latency during glmark2
 on i915 gpu
Date: Wed, 14 Oct 2015 09:51:12 +0200
Message-ID: <561E0970.8050007@gmx.net>
References: <CALqGcGpLJ+x_Gg7i4W4UCe4+GJEfdFNo-UryyOyQZJ1q5AAWJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Christoph Mathys <eraserix@gmail.com>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:59214 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501AbbJNHvQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Oct 2015 03:51:16 -0400
In-Reply-To: <CALqGcGpLJ+x_Gg7i4W4UCe4+GJEfdFNo-UryyOyQZJ1q5AAWJQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> When running cyclictest and the opengl benchmark tool glmark2 I see
> pretty severe latency spikes of about 1.8 milliseconds with kernel
> 4.1.7-rt8.
is there a high interrupt rate on '/proc/interrupts' during glmark2 
running compared to the other kernels?

Regards
     Matthias
