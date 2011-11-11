From: "Tim Sander" <tim.sander@hbm.com>
Subject: RT Throtteling with PREEMT-RT on UBIFS root fs update
Date: Fri, 11 Nov 2011 10:56:53 +0100
Message-ID: <201111111056.53803.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "LKML" <linux-kernel@vger.kernel.org>
To: "linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi

We are having a problem with a slightly patched (some platform patches,
newest stable ubifs patches) 3.0.7-rt20 kernel after updating the firmware on 
the first boot we get a message:
sched: RT throttling activated
and ksoftirqd/0 taking 95% of the cpu time.

Interestingly this only happens after the ubifs root has been updated on the 
first boot (and not allways). Subsequent boot problems have not been seen.

Any ideas whats causing this?
Tim

Sorry for noise below, please ignore:

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, Germany | www.hbm.com 

Registered as GmbH (German limited liability corporation) in the commercial register at the local court of Darmstadt, HRB 1147  
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregister des Amtsgerichts Darmstadt unter HRB 1147 
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhorst | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely for the addressee. If you are not the intended recipient, please let me know and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und lediglich fur den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail.
