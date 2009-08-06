From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
Subject: Re: [ANNOUNCE] 2.6.31-rc4-rt1 (problem with CONFIG_SYSFS_DEPRECATED_V2)
Date: Thu, 06 Aug 2009 22:09:42 +0530
Message-ID: <4A7B074E.1050907@linux.vnet.ibm.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <alpine.LFD.2.00.0904181204420.21577@localhost.localdomain> <alpine.LFD.2.00.0904251500150.4529@localhost.localdomain> <alpine.LFD.2.00.0904290036500.4529@localhost.localdomain> <alpine.LFD.2.00.0905012348200.3375@localhost.localdomain> <alpine.LFD.2.00.0905130122250.3561@localhost.localdomain> <alpine.LFD.2.00.0905221459030.3570@localhost.localdomain> <alpine.LFD.2.00.0906101803210.3367@localhost.localdomain> <alpine.LFD.2.00.0906121800590.3369@localhost.localdomain> <alpine.LFD.2.00.0906151117440.2800@localhost.localdomain> <alpine.LFD.2.00.0906170903370.2800@localhost.localdomain> <alpine.LFD.2.00.0906231418500.2767@localhost.localdomain> <alpine.LFD.2.00.0907092020410.2768@localhost.localdomain> <alpine.LFD.2.00.0907
 300006250.2936@localhost.localdomain> <4A79214B.5070003@linux.vnet.ibm.com>	<20090805083247.0b84d1c0@torg> <4A7A7C37.7020609@linux.vnet.ibm.com> <20090806093628.216bb27f@torg>
Reply-To: gowrishankar.m@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gowrishankar.m@linux.vnet.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756196AbZHFQjw@vger.kernel.org>
In-Reply-To: <20090806093628.216bb27f@torg>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Clark Williams wrote:
> On Thu, 06 Aug 2009 12:16:15 +0530
> gowrishankar <gowrishankar.m@linux.vnet.ibm.com> wrote:
> 
>> Only if I set CONFIG_SYSFS_DEPRECATED_V2=y, I could successfully boot
>> which I have tested with this kernel in same system.
>>
>> Is it not set by default from 2.6.31 onwards ?
>>
>> Thanks,
>> Gowri
> 
> I wasn't sure when it would move from 'y' to 'n', but looks like .31 is
> it. You'll need that option back on for booting on RHEL (since the boot
> infrastructure uses the old /sys format) but I don't think you'll need
> it for Fedora. Not sure about SLERT. Bet Greg Haskins would know
> though :)
> 

Thanks Clark! Yes, Fedora 10 (or 11) might have updated mkinitrd as in
https://bugzilla.redhat.com/show_bug.cgi?id=489151 , if I am right!

Regards,
Gowri
> Clark
