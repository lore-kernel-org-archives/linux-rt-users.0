From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [Kernel Panic] 3.10.10-rt7
Date: Wed, 20 Nov 2013 13:34:10 +0100
Message-ID: <528CAC42.1060706@siemens.com>
References: <9B7F15AA4177464A8FAB5BE79B14288B88967CEF@vistrex3.vi.vector.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "Frederich, Jens" <Jens.Frederich@vector.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9B7F15AA4177464A8FAB5BE79B14288B88967CEF@vistrex3.vi.vector.int>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2013-11-20 13:26, Frederich, Jens wrote:
> Hello,
> 
> I got a Kernel panic by some long time stress tests. Look here: http://dy.cx/pqP7M.

Ah, that should be http://thread.gmane.org/gmane.linux.kernel/1564783

Paul, was there any follow-up patch on this topic?

Jan

> 
> Furthermore I got sporadic some BUG messages:
> 
> [ 1128.358971] BUG: scheduling while atomic: swapper/0/0/0x00010002
> [ 1128.358982] Preemption disabled at:[<ffffffff810dfb8a>] cpu_startup_entry+0x17a/0x300
> 
> Hardware
> --------
> 
> My system is a i7 with 4 GB RAM congatec evalboard.
> 
> Setup
> -----
> 
> On the system runs Linux RT (text mode) 3.10.10-rt7 with 1 GB RAM and a
> Windows 7 KVM/QEMU (Qemu 1.6.1) guest with 3 GB RAM. Each system has it own
> ethernet card. The Win 7 guest uses it per pci pass-through. The Win 7 is
> pinned to core 2,3.
> 
> Scenario
> --------
> 
> We sending UDP packages every 1 msec on the Linux side. The UDP sender process
> has real time prio 80 and the ethernet driver 90. At the same time we are
> stressing Win 7. Memory stress - allocate as much as possible and do memset(),
> then CPU stress - high CPU load, then Kernel DPC stress - high load thread at
> DPC level and ethernet stress - send UDP packages every milliseconds. I got the
> panic after 45 minutes. It seems that is correlates with the ethernet stress.
> 
> Can anybody help me?
> 
> thanks
> Jens

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
