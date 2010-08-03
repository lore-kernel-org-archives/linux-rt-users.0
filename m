From: Klaas van Gend <klaas.van.gend@mvista.com>
Subject: Re: Run RTLinux in a VM?
Date: Tue, 3 Aug 2010 16:59:30 +0200
Message-ID: <201008031659.31787.klaas.van.gend@mvista.com>
References: <AANLkTinOFkUU1DdyWdL+YhPCiYhfEA=+zV9fpLsq-J2_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Vivek Ayer <vivek.ayer@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56952 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098Ab0HCO7j (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Aug 2010 10:59:39 -0400
Received: by fxm14 with SMTP id 14so2022274fxm.19
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Aug 2010 07:59:38 -0700 (PDT)
In-Reply-To: <AANLkTinOFkUU1DdyWdL+YhPCiYhfEA=+zV9fpLsq-J2_@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 03 August 2010 16:35:02 Vivek Ayer wrote:
> Hi all,
> 
> I'm building an application that requires the use of a real-time
> kernel. I don't have money right now to purchase a physical machine to
> run rtlinux on, and was going to try a virtual solution. Can I install
> rtlinux in kvm, qemu, or uml?

Yes, you can install it that way.

However, the effect would be similar to "upgrading" your speedometer in a car 
so the maximum speed is not 140 mph but 200 mph - the car won't go any faster!

So, if the platform isn't real time to start with, a real time kernel on top 
of that platform is not going to solve your problems.
The main kernel will happily block for indeterminate times at unexpected 
moments - your VM will only run outside of those blockages. 
Your VM's RT behavior will be worse than the original platform's.

-- 
Klaas van Gend
Senior Solutions Architect, MontaVista Software LLC

phone: +31 40 2801386
