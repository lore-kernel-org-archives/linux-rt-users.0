From: Robin Holt <holt@sgi.com>
Subject: Re: io_apic.c   -->  "nr_ioapics" not initialized !
Date: Wed, 20 Feb 2013 15:04:14 -0600
Message-ID: <20130220210414.GK3460@sgi.com>
References: <20130219035623.277664914@goodmis.org>
 <20130219035646.405150342@goodmis.org>
 <5124F7BA.5080905@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5124F7BA.5080905@steinhoff.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Feb 20, 2013 at 05:20:10PM +0100, Armin Steinhoff wrote:
> 
> Hello,
> 
> after a walk through the module "io_apic.c" in
> "/usr/src/linux/arch/x86/kernel/apic" I got the impression that the
> variable "nr_ioapics" is used but isn't initialized !

Just to be sure we are looking at the same thing, it is declared in
arch/x86/kernel/apic/io_apic.c on line 129.  Being declared that way,
it is, by definition, 0 unless there is an initializer.

Did I miss something?

Thanks,
Robin


> Could it be the source of boot problems ?
> 
> Dangerous coding stile in "static struct resource * __init
> ioapic_setup_resources(int nr_ioapics)" ....
> ########
> 
> Cheers
> 
> --Armin
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
