From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Patch serie sent to linux-rt-user failed to apply
Date: Fri, 22 Dec 2006 08:16:53 +0100
Message-ID: <458B8665.9040606@gmail.com>
References: <a0580c510612210603o36539246w8e9be6cf3427d69e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:63581 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945954AbWLVHRA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Dec 2006 02:17:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2894559uga
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Dec 2006 23:16:59 -0800 (PST)
To: Eduardo Valentin <edubezval@gmail.com>
In-Reply-To: <a0580c510612210603o36539246w8e9be6cf3427d69e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Eduardo Valentin wrote:
>   I'm trying to apply your patch serie sent to linux-rt-user and they
> are failing while applying.
> I followed the instructions as in
> http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg00079.html
> 
> linux-2.6.19 + patch-2.6.20-rc1 + patch-2.6.20-rc1-rt0 + your patch serie
> 
>  Do you have any idea?

I think you are working on OMAP?

Where/What fails?

Can you try patch-2.6.20-rc1-rt3 instead? So

linux-2.6.19 + patch-2.6.20-rc1 + patch-2.6.20-rc1-rt3

My patch series should be included in it now.

Dirk
