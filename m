From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Parport and RT_PREEMPT
Date: Tue, 6 May 2008 18:12:56 -0300
Message-ID: <20080506211256.GH16373@unix.sh>
References: <20080503210605.GA16610@alumnos.inf.utfsm.cl> <59303.200.1.19.97.1210107222.squirrel@wmalm.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mauricio A. Araya L?pez" <maray@inf.utfsm.cl>,
	linux-rt-users@vger.kernel.org
To: maray@alumnos.inf.utfsm.cl
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fb02-01.mta.terra.com.br ([200.154.152.120]:52541 "EHLO
	fb02-01.mta.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761662AbYEFVib (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 May 2008 17:38:31 -0400
Received: from sr03-07.mta.terra.com.br (sr03-07.mta.terra.com.br [200.154.152.46])
	by orilia.hst.terra.com.br (Postfix) with ESMTP id 8689E2843B73
	for <linux-rt-users@vger.kernel.org>; Tue,  6 May 2008 18:16:01 -0300 (BRT)
Content-Disposition: inline
In-Reply-To: <59303.200.1.19.97.1210107222.squirrel@wmalm.inf.utfsm.cl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, May 06, 2008 at 04:53:42PM -0400, maray@alumnos.inf.utfsm.cl wrote:
| > Hi,
| >
| > I am trying to use the parport interrupt (pin 10) on a RT_PREEMPT Linux
| > Kernel. I am using the parport_pc module to register a custom driver
| > that synchronize the clocks using an external clock generator, by
| > sending a signal to the parport interrupt pin 10 (ACK). With kernel
| > 2.4.24 i have no problems on using the interface that the parport_pc
| > driver offers me.  But, as my userspace applications needs RT, i've
| > installed the RT_PREEMPT patches, and my driver is not working now. The
| > attach function of my driver is:
| [...]
| >
| > This should be enough to register my driver with the parint_handler
| > function as the "callback" when the IRQ (7) ocurrs.  In summary, i am
| > registering the device, the callback, enabling the IRQ at the control
| > register (0x10), and enabling the IRQ in the parport_driver.
| 
| Ok. It seems to work for very limnited time quantums. Maybe the interrupt
| handler thread IRQ7 should have a higher priority, but i dont know how to
| do this... :S

You can change the source to start the thread with right prio (although
that may be tricky to make sure which thread is that) or correlate data
from 'ps' and /proc/interrupts to find the right process and use chrt on
it.

If it is always [IRQ-7] you are looking for, the lines below should be
enough:

chrt -p 80 `ps -Ao pid,cmd | grep "\[IRQ-7\]"| cut -f2 -d\  `

Here, 80 is the priority.

Luis

| > I've change the IRQ flags to IRQF_NODElAY in the parport driver,
| > and I've write also a module without using the parport_pc,
| > and still the interrupt denies to works.
| 
| --
| To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

