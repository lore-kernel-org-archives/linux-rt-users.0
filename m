From: Priyanka Gupta Jain <p.priyankagupta@gmail.com>
Subject: what to use in threaded ISR routine in place of in_irq()
Date: Wed, 25 Apr 2012 16:32:08 +0530
Message-ID: <CACpc7pc8b3x63fnHEmakU5KdyPHRfWzuuwLWCjXdAYaA-DiwWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49213 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758134Ab2DYLCJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Apr 2012 07:02:09 -0400
Received: by ghrr11 with SMTP id r11so999940ghr.19
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Apr 2012 04:02:09 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hi,

While running in one of ISR routine, we have a call to function x()
which makes a call to in_irq() to check if the function x() has been
called in ISR context or from some other process and do the processing
accordingly.
This scenario works fine in case of hard ISR.

But with PREEMPT_RT patch, ISR routine gets converted into threaded
ISR and now in function x(), we can not use in_irq() to distinguish
beween threaded isr or some other process context.

Is there any function in PREEMPT_RT kernel similar to in_irq(), which
I can use to check if running in threaded isr context or not


Regards
Priyanka
