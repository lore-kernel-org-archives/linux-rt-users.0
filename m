From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.4.41-rt55-feat1
Date: Thu, 25 Apr 2013 08:36:34 -0400
Message-ID: <1366893394.10248.1.camel@gandalf.local.home>
References: <1366760662.9609.176.camel@gandalf.local.home>
	 <2156546.QlsX0XyPQz@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2156546.QlsX0XyPQz@dabox>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2013-04-25 at 13:14 +0200, Tim Sander wrote:
> Hi 
> 
> I just wanted to test this release but it fails to compile with the the 
> following error:
> 
> kernel/hrtimer.c: In function '__hrtimer_start_range_ns':
> kernel/hrtimer.c:1045:7: error: implicit declaration of function 
> 'hrtimer_rt_defer'
> kernel/hrtimer.c: At top level:
> kernel/hrtimer.c:1416:12: error: static declaration of 'hrtimer_rt_defer' 
> follows non-static declaration
> kernel/hrtimer.c:1045:10: note: previous implicit declaration of 
> 'hrtimer_rt_defer' was here
> 

Thanks for the report. I'll have a look at it.

-- Steve

> The kernelconfig is attached.
> 
> Best regards
> Tim
> Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, Germany | www.hbm.com 
> 
> Registered as GmbH (German limited liability corporation) in the commercial register at the local court of Darmstadt, HRB 1147  
> Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of the board: James Charles Webster
> 
> Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregister des Amtsgerichts Darmstadt unter HRB 1147 
> Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhorst | Aufsichtsratsvorsitzender: James Charles Webster
> 
> The information in this email is confidential. It is intended solely for the addressee. If you are not the intended recipient, please let me know and delete this email.
> 
> Die in dieser E-Mail enthaltene Information ist vertraulich und lediglich fur den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail.
