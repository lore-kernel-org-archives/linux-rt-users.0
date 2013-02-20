From: Armin Steinhoff <armin@steinhoff.de>
Subject: io_apic.c   -->  "nr_ioapics" not initialized !
Date: Wed, 20 Feb 2013 17:20:10 +0100
Message-ID: <5124F7BA.5080905@steinhoff.de>
References: <20130219035623.277664914@goodmis.org> <20130219035646.405150342@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130219035646.405150342@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Hello,

after a walk through the module "io_apic.c" in 
"/usr/src/linux/arch/x86/kernel/apic" I got the impression that the 
variable "nr_ioapics" is used but isn't initialized !
Could it be the source of boot problems ?

Dangerous coding stile in "static struct resource * __init 
ioapic_setup_resources(int nr_ioapics)" ....
########

Cheers

--Armin
