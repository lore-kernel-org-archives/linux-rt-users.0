Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7A9C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B74D21734
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akMQ1cnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgAWUul (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:50:41 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:35237 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAWUul (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:50:41 -0500
Received: by mail-qk1-f182.google.com with SMTP id z76so4943604qka.2
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2020 12:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/n+BG/kL8a4ayV/8eKCyegAiqJ1nocxg/M4Z7WA02rE=;
        b=akMQ1cnCw3HIkU2VD/Od+vpL84xkp/jAy2NWwcUuWte6Mqht55R9x5cj6OE/OHX6uq
         QcjUPAOZWJ//Kr3iurD57ai/0W5UhcAg63ir8YPbgv6RQbkbx/g/ldDrcHqK9ly3PHhb
         tHHnHfQg0p6gpTPnBwo0oe0w11KRm52736SFRd1HJpcsHHyNC7qn/lI6CSjX5CqBmZrJ
         fdB0lX/WxHIPcbaQUL3Z+PWLk4mdB85Z+AjEYzAVq1vkE4Q5N1cqEFuVyK3OEgfogej0
         my45kBLXKFMufS0X2KCAJswML8T2OSNqRQ05qoDvsCxhIObGxMKdc3WsvoUO9MCgddf1
         c3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=/n+BG/kL8a4ayV/8eKCyegAiqJ1nocxg/M4Z7WA02rE=;
        b=GcxpEVjjfKGKAGYDma1czNpACywJH2PEoQsBPColIifGbBMbUTI9x1RT3EVWBWb+/m
         KQhRO02n4EWGqdSezR8a1d23kjUBItkgN/Kj/Vu38wZgxIaMbsTRYUa9wDHDepnYj79q
         spt1TP/LRFjbz0DBaZcD/e1yk16VSJFbQ4jHFDGDEePeTIwXnnw87Fi0q+jPI1G5tQD4
         siVG9+H/qRXBPl4GyTgiZVinjaG5vIv7WxV6Q1Y41bq2qOmRWjO8untWeOFyUkD1MpB8
         1zhqy8V5y9iTb1BB4sKFsn3VJ7pxeXjgI3e8cIX7OgqmqgihtVGS77fgnVTu1ErS04rg
         H+ig==
X-Gm-Message-State: APjAAAU7XWC3S3VxP1i57KuX8zlVQdZYGUz0r3Y1bK+Gql6Yuq7xt9EY
        rzsyrwL6AuejtOQNUgA0UZch7rCxp04=
X-Google-Smtp-Source: APXvYqxwWlioKY0AnhC9e1JLPeSBIZTCHoOey5SUpSUSLPYnl2Ug994TypAkLznv0Q9tA5h/WD7rDg==
X-Received: by 2002:a05:620a:1479:: with SMTP id j25mr18471147qkl.491.1579812640074;
        Thu, 23 Jan 2020 12:50:40 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id j185sm1518346qkc.96.2020.01.23.12.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 12:50:39 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/9] rt-tests: Miscellaneous fixes 
Date:   Thu, 23 Jan 2020 21:50:20 +0100
Message-Id: <20200123205029.20176-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Most of the fixes here are just clean-ups to make sure that online help
or usage message match the man pages according to the current options.

Some fixes to the queuelat scripts determine_maximum_mpps.sh and
get_cpuinfo_mhz.sh are perhaps notable though, as people were having
trouble using them.

getcpuinfo_mhz.sh now only gets one value as was originally intended,
and it gets the highest value available. The fixes to quoting in
determine_maximum_mpps.sh should make the program work correctly now -
and take longer though.

John Kacur (9):
  rt-tests: queuelat: Assume queuelat is in the path
  rt-tests: cyclicdeadline: Add a simple manpage for cyclicdeadline
  rt-tests: pi_stress: Add short options to usage message
  rt-tests: pi_stress: Sync man page with help
  rt-tests: queuelat: get_cpuinfo_mhz.sh highest value
  rt-tests: determine_maximum_mpps.sh: Fix quoting and other shell issue
  rt-tests: ptsematest: Update man page and add -h option
  rt-tests: queuelat: Fixes to man page and display_help
  rt-tests: svsematest: Display help with an error message for -h

 Makefile                               |  1 +
 src/pi_tests/pi_stress.8               |  9 ++--
 src/pi_tests/pi_stress.c               | 34 ++++++------
 src/ptsematest/ptsematest.8            |  3 ++
 src/ptsematest/ptsematest.c            | 10 ++--
 src/queuelat/determine_maximum_mpps.sh | 75 +++++++++++++-------------
 src/queuelat/get_cpuinfo_mhz.sh        |  5 +-
 src/queuelat/queuelat.8                |  4 +-
 src/queuelat/queuelat.c                | 22 ++++----
 src/sched_deadline/cyclicdeadline.8    | 53 ++++++++++++++++++
 src/svsematest/svsematest.c            |  3 +-
 11 files changed, 141 insertions(+), 78 deletions(-)
 create mode 100644 src/sched_deadline/cyclicdeadline.8

-- 
2.20.1

