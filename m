From: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Subject: Re: [ANNOUNCE] 3.6.9-rt21
Date: Thu, 6 Dec 2012 21:52:17 +0100
Message-ID: <201212062152.17589.tim01@vlsi.informatik.tu-darmstadt.de>
References: <alpine.LFD.2.02.1212051659160.2701@ionos> <201212061535.37585.tstone@iss.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201212061535.37585.tstone@iss.tu-darmstadt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi
> Also: Has s.th. changed in respect to the modules. I have one module wich
> goes on an endless interrupt loop freezing the device. The driver works
> fine for 3.0  - 3.4 preempt rt kernels? This is a miscdev based driver. If
> someone is interested i can post the source over here. But unfortunatly i
> have not figured out why this thing goes to an endless interrupt. The
> identical driver works flawless on 3.4.

I have just crosschecked with 3.6.9. The same error as with the preempt rt 
version. So it's not an preempt rt problem.

Best regards
Tim
