From: Daniel Walker <dwalker@mvista.com>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Mon, 05 Feb 2007 17:14:17 -0800
Message-ID: <1170724457.9781.327.camel@imap.mvista.com>
References: <20070205065636.GA1652@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:10049 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S965430AbXBFBQW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Feb 2007 20:16:22 -0500
In-Reply-To: <20070205065636.GA1652@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


The /proc/interrupts timer entry is dangling a little. With PREEMPT_RT
the entry doesn't get updated ..

My system after two hours uptime,

           CPU0       CPU1       
  0:         56          0   IO-APIC-edge      timer
  1:          2          0   IO-APIC-edge      i8042
  4:       1450          0   IO-APIC-edge      serial
  6:          3          0   IO-APIC-edge      floppy
  8:          0          0   IO-APIC-edge      rtc
  9:          0          0   IO-APIC-fasteoi   acpi
 12:          4          0   IO-APIC-edge      i8042
 14:     824890          0   IO-APIC-edge      ide0
 17:        182          0   IO-APIC-fasteoi   HDA Intel
 20:          0          0   IO-APIC-fasteoi   uhci_hcd:usb2
 21:          0          0   IO-APIC-fasteoi   libata, ehci_hcd:usb1, uhci_hcd:usb4
 22:          0          0   IO-APIC-fasteoi   uhci_hcd:usb3
 23:       7515          0   IO-APIC-fasteoi   uhci_hcd:usb5, eth0
NMI:          0          0 
LOC:    1749635    1749614 
ERR:          0

Daniel
