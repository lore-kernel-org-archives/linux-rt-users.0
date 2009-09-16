From: Meha Mehta <mehtameha@gmail.com>
Subject: SoftIRQ preemption
Date: Wed, 16 Sep 2009 15:27:15 -0400
Message-ID: <af81d2bf0909161227p60945fe1lf5a80ec2815150c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:42158 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758832AbZIPT1M (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Sep 2009 15:27:12 -0400
Received: by yxe1 with SMTP id 1so7023240yxe.21
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Sep 2009 12:27:16 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

I have a question regarding SoftIRQ in Linux RT patch. I see that
preemption is disabled during softirq execution. Shouldn't they be
preemptible? If not, what are the problems in Linux with SoftIRQ
preemption?

Thank you in advance for your help.

Thanks,
Meha
