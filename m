Return-Path: <SRS0=vaL9=Z3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62995C43603
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Dec 2019 13:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6A82464E
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Dec 2019 13:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfLENuW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:50:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:37348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729187AbfLENuW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Dec 2019 08:50:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89914B020;
        Thu,  5 Dec 2019 13:50:21 +0000 (UTC)
Date:   Thu, 5 Dec 2019 14:50:20 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-rt-users@vger.kernel.org, rt@linutronix.de
Cc:     ltp@lists.linux.it
Subject: LTP realtime tests
Message-ID: <20191205135020.GA7951@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi RT folks,

looking into LTP realtime tests (testcases/realtime/ [1]),
the code certainly deserves cleanup.

Looking at [2], it does not mention these tests at all.
Can anyone comment on relevance of these tests to current RT?
Does anyone use these tests?

Thanks for feedback.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/tree/master/testcases/realtime
[2] https://elinux.org/Realtime_Testing_Best_Practices#Test_programs
