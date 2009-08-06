From: John Kacur <jkacur@gmail.com>
Subject: Re: [ANNOUNCE] 2.6.31-rc4-rt1 (problem with CONFIG_SYSFS_DEPRECATED_V2)
Date: Thu, 6 Aug 2009 16:55:22 +0200
Message-ID: <520f0cf10908060755v11fd771buae6bb6c905a454df@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0906151117440.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906170903370.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906231418500.2767@localhost.localdomain>
	 <alpine.LFD.2.00.0907092020410.2768@localhost.localdomain>
	 <alpine.LFD.2.00.0907300006250.2936@localhost.localdomain>
	 <4A79214B.5070003@linux.vnet.ibm.com> <20090805083247.0b84d1c0@torg>
	 <4A7A7C37.7020609@linux.vnet.ibm.com> <20090806093628.216bb27f@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
	Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755628AbZHFOzY@vger.kernel.org>
In-Reply-To: <20090806093628.216bb27f@torg>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Aug 6, 2009 at 4:36 PM, Clark Williams<williams@redhat.com> wrote:
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
> Clark
>

The default 'n' works fine for Fedora 10 and Fedora 11.
