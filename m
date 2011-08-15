From: "Tim Sander" <tim.sander@hbm.com>
Subject: CONFIG_PEEMPT_RT_FULL vs. CONFIG_PREEMPT_RTB
Date: Mon, 15 Aug 2011 16:04:53 +0200
Message-ID: <201108151604.54251.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Peter Zijlstra" <peterz@infradead.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"Remy Bohmer" <linux@bohmer.net>
To: "linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi

I have more than twice as much cpu load when running the  
CONFIG_PREEMPT_RT_FULL=y kernel compared to CONFIG_PREEMPT_RTB=y. First i 
thought that might be the difference that one config had softirqs enabled and 
the other not. Now i realized that softirqs are already enabled with 
CONFIG_PREEMPT_RTB so i don't see a good reason why the CONFIG_PREEMPT_RT_FULL 
option should have two times more cpu load than CONFIG_PREEMPT_RTB.

The arm1136 cpu (533Mhz pcm043) has 9.6khz interrupt rate so i surely expect 
some load. But i wouldn't expect so much difference between 
CONFIG_PREEMPT_RT_FULL and CONFIG_PREEMPT_RTB. So does anybody has an idea 
what might a reason to so much more cpu load when going to full preemption?

Besides of the cpu load i also found out that with rt11 i can again wake up 
usermode from a IRQF_NO_THREAD waiting on a waitqueue. So the steps outlined 
in this mail http://www.spinics.net/lists/linux-rt-users/msg06834.html do not 
seem to be neccessary anymore? Or does this create an error and than some high 
load?

Best regards
Tim

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, Germany | www.hbm.com 

Registered as GmbH (German limited liability corporation) in the commercial register at the local court of Darmstadt, HRB 1147  
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregister des Amtsgerichts Darmstadt unter HRB 1147 
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhorst | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely for the addressee. If you are not the intended recipient, please let me know and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und lediglich fur den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail.
