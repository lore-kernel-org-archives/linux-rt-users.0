Return-Path: <SRS0=P/LD=UL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC50AC31E46
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Jun 2019 11:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A575620896
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Jun 2019 11:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUFdHiV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391831AbfFLLxe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:53:34 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:41226 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387878AbfFLLxe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Jun 2019 07:53:34 -0400
Received: by mail-io1-f46.google.com with SMTP id w25so12653254ioc.8
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Jun 2019 04:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5xaVdtWDlNxlgJWceC/ElifBtReyRMe0ykgNTIxRc/E=;
        b=SUFdHiV5ilmdrjKORVOGKGM3VvppzREOnoufhgPNvWPpygCu1tq6aB839zyleJKsfz
         86tiLFwh+iaX8/royv9lXndhvxGlm2uepYa07HzA/aCsBJUaUZlHEFYuvPAH2Vr2J0Qv
         2hNtFSIgYOv7hWKjqogg+1fmZBJXxDdMn5GNy9ucA7HPWQnFDyUcNrrAAa9t+HKYe7Pu
         zFYYd3+W5Webc42+9eZtiPskecjhJ9WfSA4a0h1KSvDypEvXxmAA4l9IZKElDpHRmOz+
         XrN+zpAW3emSFfKAc6GRsZTRYPq4WJP/hBmYx7fXhPULvRATGoppOEjx0zPocqo2u6+S
         uuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5xaVdtWDlNxlgJWceC/ElifBtReyRMe0ykgNTIxRc/E=;
        b=Vt07otYGUNq1GxJhBZG8nj4bQtbZITbZPPDXbhkKvzZeeA27HZfHrF9pzh5jLY2nmd
         TfqyY1JTXbjjJfAN3NaHHwAB5yN7mpn/jolSoUevIy27BlGMxvHFViP0Fq6fXbNE5Ys+
         ZrzyM5S7kD6r1xB9yF7RBv0cK7VNuhmW7Xca2clFxanxaqW/ke3n7L8SmD1xUF5HCBFR
         4njE+DogxW8gzcXmay4Sms9SrdF9KzHEJlvfF9lKTr2Fk3PsUKzHVws3WOFN4IGfzkmY
         y56B5trVnAvAKPh+dsIIB8wU1O1zst/AvAGZpbOd80gP90pQcomnp89DDZFLTWQI1kHQ
         aMSg==
X-Gm-Message-State: APjAAAW8HHVlNYDxkSz+TYpwzTEq+XoE2/J1Q8r6mvKxQKykqJU4OdkQ
        Z+uVdQc5MHxjkzuj1hq8pKZSsHS3w5g2VDo0EnUlZJN2+vY=
X-Google-Smtp-Source: APXvYqz8eurT2ZHr7URMWXbtixUGoL4DtMkpoWAaB0U333zWRGjwB0P4iPHh1xzpoR2Qsf1vsapRRMX1JDuiL6wReeA=
X-Received: by 2002:a6b:4107:: with SMTP id n7mr7235623ioa.12.1560340413178;
 Wed, 12 Jun 2019 04:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABaQWj5C2e_ttTnC2CdZX-j_9n+ASfnthR4T_F2-sNYX9CNBOw@mail.gmail.com>
In-Reply-To: <CABaQWj5C2e_ttTnC2CdZX-j_9n+ASfnthR4T_F2-sNYX9CNBOw@mail.gmail.com>
From:   Felipe Lavratti <felipelav@gmail.com>
Date:   Wed, 12 Jun 2019 08:52:57 -0300
Message-ID: <CABaQWj4iay+g5Ooe3Okh24qnP2PMD1DSzv4eEwTaWCjHaRQLLg@mail.gmail.com>
Subject: irq kthreadd spwned threads priority set up from user space applications
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

Setting up irq kthreads priorities via the POSIX calls works fine, as
expected, but due to the way those threads are created (`request_irq`
calls) it seems that we cannot control thread priority
deterministically since they are created under `kthreadd` PPID and any
user-space application would have to query by string to find what is
the irq kthread PID to then tweak it.

I am not sure how the irq kthread priority is defined, on my system
they are always on -51, yet, in real-time embedded systems it is
sometimes necessary to tune those priorities, i.e, increase the tty
and decrase the eth0, depending on the application.

Can you please confirm if my affirmatives are correct, that we
currently lack the capacity to set irq kthread priorities at user
space system level?

In an ideal setup, we should have a way of up-front setting up
priorities in which any irq ktreadh would be created with. Would you
agree?
