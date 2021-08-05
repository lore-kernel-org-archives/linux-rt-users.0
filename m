Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD9AC4338F
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 06:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8754D60EC0
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 06:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhHEGyK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:54:10 -0400
Received: from mail.nearlyone.de ([46.163.114.145]:37054 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbhHEGyJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 02:54:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E74E960D9D;
        Thu,  5 Aug 2021 08:53:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1628146433; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=7cQZRpoS+7PG3sCRXuCSbnwXMO2IhjOs5j8hHhve5SQ=;
        b=fnj6gLeVf3O6SjMabfitICMuDIlPp1HbZ3xgrPpOS8apMCAtCo6qZp1v9oWH/s3l3bfb52
        7txbsRtHjJnXgjCLynfFfe17k3en44GJ8ZKTJupnMnh17rAaOnSd52sOVS5n17YgIwSf9H
        Z71l1I/pVFG0aCamkLzXygWTiutw9VgasPH9wYu0D10GdP1mZrE2TRV/MbXwrHd35HRHlM
        C7KGTAJ8Ux64XzFKDTiqZanjUIAVTULC/SHxdNqVCvRJv2f82m1e9NPUPqJ60efxgZB/QM
        OnHFnRpTxkJswgW5+mjEvb2MVHCiuDIKxQFzit+LWZGZyzegqeSa/qf7hEFwzA==
Date:   Thu, 5 Aug 2021 08:53:51 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.14-rc4-rt5
Message-ID: <20210805065351.c7eieltqihduwisr@beryllium.lan>
References: <20210804165017.nizmbj3m7hkqzqop@linutronix.de>
 <20210805063123.mj4rggncauziryv4@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805063123.mj4rggncauziryv4@beryllium.lan>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 05, 2021 at 08:31:23AM +0200, Daniel Wagner wrote:
> Just a heads up. I get these build errors:

I suppose this should be:

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -127,33 +127,33 @@ struct task_group;
        ((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED | TASK_DEAD))
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-# debug_normal_state_change(state_value)                               \
+#define debug_normal_state_change(state_value)                         \
        do {                                                            \
                WARN_ON_ONCE(is_special_task_state(state_value));       \
                current->task_state_change = _THIS_IP_;                 \
        } while (0)
 
-# debug_special_state_change(state_value)                              \
+#define debug_special_state_change(state_value)                                \
        do {                                                            \
                WARN_ON_ONCE(!is_special_task_state(state_value));      \
                current->task_state_change = _THIS_IP_;                 \
        } while (0)
 
-# debug_rtlock_wait_set_state()                                                 \
+#define debug_rtlock_wait_set_state()                                   \
        do {                                                             \
                current->saved_state_change = current->task_state_change;\
                current->task_state_change = _THIS_IP_;                  \
        } while (0)
 
-# debug_rtlock_wait_restore_state()                                     \
+#define debug_rtlock_wait_restore_state()                               \
        do {                                                             \
                current->task_state_change = current->saved_state_change;\
        } while (0)
 #else
-# debug_normal_state_change(cond)      do { } while (0)
-# debug_special_state_change(cond)     do { } while (0)
-# debug_rtlock_wait_set_state()                do { } while (0)
-# debug_rtlock_wait_restore_state()    do { } while (0)
+#define debug_normal_state_change(cond)        do { } while (0)
+#define debug_special_state_change(cond)       do { } while (0)
+#define debug_rtlock_wait_set_state()          do { } while (0)
+#define debug_rtlock_wait_restore_state()      do { } while (0)
 #endif
 

