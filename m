Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34029C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E432620684
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt656ung"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgAWUuq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:50:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42385 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAWUup (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:50:45 -0500
Received: by mail-qk1-f196.google.com with SMTP id q15so4890181qke.9
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2020 12:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tA6xWF4OiGf3KLjGAKnbOMhD28U+NdPd47NjH9GykIc=;
        b=Xt656ungzYPuYTE+ahZReHSIc89zIQTCOwgiU61Oa9boEt/l2DrShP+SMdAWwNpi00
         B47+wu8kRY5rZHBK7U7Asj0juzi8NTaQgCn0LaC8Ul+ZckU70C+l1LOGsB5cXnCtrmG+
         HkWSktbv6nAkCq7pdPQR1lJycqONnC7XX06zvgiyg4WvObHovftWwAqZW0JIUj9qh09n
         lbABn04VkMzmDgZjv/KDRE7QeaWELOPdPB2gCa8TXH3cPpRT5ryJY2fNcgJV/DUFxGD4
         flBHzlqi2Pe0zBROWH7YfyMyRbbUuK1J/ooPcfm9E26uHFNYUzp9Z3zmpXUr4I2Fcmi3
         9Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tA6xWF4OiGf3KLjGAKnbOMhD28U+NdPd47NjH9GykIc=;
        b=OyAnrjr65umWVNS1a0pxtKUjBsDqP0PSl/iZxURB+V7E5jGMCOEUWAtvuExEb1HOmn
         /4AthGA5UGfW0MA5umFe75Ba0LYrG4ZDukzaMl1npfNdJcahrLYfBUSoT/j1OxnwOSM2
         LDHc3TFIao/yyDjpzydxtGlHCDACMM0E90oS5xqlJNdOEH7urSCW594lXeriZ8OZNF9W
         Os0O4toIKCqI+z6/u0GPqtNjZK8CGZYiP2d8eEtzkbLveLD3JVwJJV8Q/+f8WTXRa7fr
         hdPzw8Ecmq5O1NTE0lqks1t7coX7Z0JOeQb+q2RoiVS77O71O67r3pwZeCFtugYgGk64
         MizQ==
X-Gm-Message-State: APjAAAW9DwT9L0VGRdOdBrOAgGygQuCTsOaYUHj5HBY0uHwRCtTIol60
        OQqtCdU3jEEHM+PHdvgq7XgeY5tCa/8=
X-Google-Smtp-Source: APXvYqzOUSHrpO1pi+ATP22OBp2EuatB3ROPng3vJNKR/LVA+D7NFYfTvLrQM1WGf4gpIQJDKwRsGQ==
X-Received: by 2002:a05:620a:1324:: with SMTP id p4mr18541857qkj.497.1579812644496;
        Thu, 23 Jan 2020 12:50:44 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id j185sm1518346qkc.96.2020.01.23.12.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 12:50:44 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/9] rt-tests: pi_stress: Sync man page with help
Date:   Thu, 23 Jan 2020 21:50:24 +0100
Message-Id: <20200123205029.20176-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123205029.20176-1-jkacur@redhat.com>
References: <20200123205029.20176-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Sync the man page with help.
Specifically, remove the signal option which is not supported and
document the sched option

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.8 | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
index 475d3c34f135..5e2af6189ca1 100644
--- a/src/pi_tests/pi_stress.8
+++ b/src/pi_tests/pi_stress.8
@@ -21,7 +21,8 @@ pi_stress \- a stress test for POSIX Priority Inheritance mutexes
 .IR groups
 .RB [ \-d|\-\-debug ]
 .RB [ \-v|\-\-verbose ]
-.RB [ \-s|\-\-signal ]
+.RB [ \-s|\-\-sched
+.IR sched_opts ]
 .RB [ \-r|\-\-rr ]
 .RB [ \-p|\-\-prompt ]
 .RB [ \-m|\-\-mlockall ]
@@ -63,12 +64,12 @@ Specify a length for the test run.
 Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .IP \-v|\-\-verbose
 Run with verbose messages
-.IP \-s|\-\-signal
-Terminate on receipt of SIGTERM (Ctrl-C). Default is to terminate on
-any keypress.
 .IP \-r|\-\-rr
 Run inversion group threads as SCHED_RR (round-robin). The default is
 to run the inversion threads as SCHED_FIFO.
+.IP \-s|\-\-sched
+scheduling options per thread type:
+id=[high|med|low],policy=[fifo,rr],priority=<n>,policy=deadline,runtime=<n>,deadline=<n>,period=<n>
 .IP \-p|\-\-prompt
 Prompt before actually starting the stress test
 .IP \-u|\-\-uniprocessor
-- 
2.20.1

