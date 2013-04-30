From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [ANNOUNCE] 3.4.41-rt55-feat3
Date: Tue, 30 Apr 2013 11:14:36 +0200
Message-ID: <2805818.g7STVSuEne@dabox>
References: <1367283987.30667.49.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "LKML" <linux-kernel@vger.kernel.org>,
	"RT" <linux-rt-users@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Carsten Emde" <C.Emde@osadl.org>, "John Kacur" <jkacur@redhat.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Class: urn:content-classes:message
In-Reply-To: <1367283987.30667.49.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve and all RT Folks

> I'm pleased to announce the 3.4.41-rt55-feat3 feature release.
> 
> Note, I first uploaded -feat2 then realized I didn't add a compile fix by
> Mike Galbraith, and then created the -feat3 with that fix.
I just wanted to say thanks that this patch enables compilation again with the 
preempt rt patchset with CONFIG_HIGH_RES_TIMERS disabled :-). 
I think this patch* should be moved out of the feat patchset into the stable 
rt backport branch as this also doesn't compile beginning with the 3.6.36-rt50 
patch with CONFIG_HIGH_RES_TIMERS disabled .

As i understand that SLUB should give better realtime latencies? At least i 
configured the kernel that way an its currently running some tests. 

Best regards
Tim


*That is the coresponding line:
patch-3.4.41-rt55-feat3.patch:55:+#if defined(CONFIG_PREEMPT_RT_BASE) && 
defined(CONFIG_HIGH_RES_TIMERS)

Please ignore this legalese as always on public lists (its attached 
automatically):

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, Germany | www.hbm.com 

Registered as GmbH (German limited liability corporation) in the commercial register at the local court of Darmstadt, HRB 1147  
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregister des Amtsgerichts Darmstadt unter HRB 1147 
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhorst | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely for the addressee. If you are not the intended recipient, please let me know and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und lediglich fur den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail.
