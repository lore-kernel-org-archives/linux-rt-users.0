From: Joel Fernandes <agnel.joel@gmail.com>
Subject: Clarification about IRQ terminology
Date: Wed, 5 Oct 2016 23:07:55 -0700
Message-ID: <CAD=GYpbv_okzpb22bHgmQZDhJzkyy+yJk_ZMaOc25e9Gks0A=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35777 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbcJFGH6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Oct 2016 02:07:58 -0400
Received: by mail-lf0-f42.google.com with SMTP id l131so6380962lfl.2
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Oct 2016 23:07:57 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Recently had a discussion with a colleague about hard vs soft irqs. We
also discussed process vs interrupt context and I had some confusion
about when to (and when not to use) the terms hard irq handler.

Just to clarify and use the right terminology, I'd like to understand
whether the "hard" in hard irq implies interrupt context?

To further confuse the matter, with CONFIG_PREEMPT_RT_FULL, all IRQs
previously executing in interrupt context are now threaded. Then in
this scenario, is it Ok to still call these irq handlers as hard irq
handlers or should they now be strictly called threaded interrupt
handlers now that the same handlers are forced to execute in a thread?
If the "hard" in hard irq means hardware interrupt, then it would make
sense to still call them hardirq handlers even though they're now
executing in process context?

So basically my questions are:
1. Does hard in hard irq mean hardware interrupt or does it imply
interrupt context?
2. Can the terms "hard irq handler" still be used with CONFIG_PREEMPT_RT_FULL?

Thanks a lot,

Joel
