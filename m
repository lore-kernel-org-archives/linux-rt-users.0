Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACEBC432BE
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FAF060F91
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhH0WD5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhH0WD4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Aug 2021 18:03:56 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0774C0613D9
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:06 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id a5so4897806qvq.0
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MUca3HO8QgKoQBjsRo9MxV9y3SE6HnfPoqAnvwRduTU=;
        b=uLTdFybgSJ+2vVflRfN3KQbYdkt56SLnxJsGqhbikdSE1Ox1gEVHeg0TILi/lHu60I
         0SQFC1d0xibuETge48lkDM1PbA5UkqGD+OvJ/zI8N89HCyJrgrMeS43xOUsHzjHuxZv9
         0+tk1Go6A3W8J6KCXFt7uuTLiMcI0mhEN3RahMD9D5hSl+NHgt/xep+Ika8qBrRRj84p
         NM4rZjMv3f8ZtKAIBDUlt7OuD4J3RMkLiyyhtef90MuDA2IyayVw/b0/PcQZPnb/ngEI
         hsQPtLDokZYODLspx6aZvkKEfnGyjg+3r4HtZk2omdH7FZzflx7AWjYS3SyxTKqSG8zR
         McAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MUca3HO8QgKoQBjsRo9MxV9y3SE6HnfPoqAnvwRduTU=;
        b=ORbe41jkyKpQikvDFA72roR1ndfujrcRqmxlHDTSlOsd5c8J6a2vvMFF32U7+Qi/z9
         C1zoV+TvPHwIT2+1iN0kjxbPo33X5v72IHaG3+ZlIMzPNiXdrgeNuH1DNyLmu2j88WZg
         YjlrdiLKHqxTy+x6rC2Hm2IFFa/qDy9f9aCjcfR4fKglco5hhkiBygprxIwzElTGn1rp
         wk/XL6LKm41m4dhHHO9hqzRV4XNA3rbhXZDuHxEz5J3YBCB0XdMT0FtFbLMKLFpfDg4M
         DAn9j1V/6X5QMOS77Ta47Vjm0PU0DWXRXU2wzNEb6dWLngGIKYCwzqdVh1NPzayqZYHv
         7ImQ==
X-Gm-Message-State: AOAM532PUCQtz5A0LgJXU3GsSOx1u4rPhH8FePhThNpN51vQWMyXJjN9
        /MhU53cMOiL7F+MspBQttwFDrRnAFxX3Ug==
X-Google-Smtp-Source: ABdhPJwdFQycDcgDP5uMb1NtabI/+UeBLxdHrqWQp2TtO2BuvZfccjNJXY+3J+fOQJ27nmDvM72rFw==
X-Received: by 2002:a05:6214:5185:: with SMTP id kl5mr12081573qvb.47.1630101785853;
        Fri, 27 Aug 2021 15:03:05 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id t64sm5659209qkd.71.2021.08.27.15.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 15:03:05 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 7/8] rt-tests: deadline_test: Exit with message if threads less than 1
Date:   Fri, 27 Aug 2021 18:02:43 -0400
Message-Id: <20210827220244.24210-8-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827220244.24210-1-jkacur@redhat.com>
References: <20210827220244.24210-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If the user tries to run deadline_test with threads less than  1 (zero
for example), then exit with an error message.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/deadline_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index 1763c71486a9..53abd4d2ca6b 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -1817,6 +1817,11 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
+	if (nr_threads < 1) {
+		fprintf(stderr, "The number of threads must be at least 1\n");
+		exit(-1);
+	}
+
 	if (setcpu) {
 		nr_cpus = calc_nr_cpus(setcpu, &setcpu_buf);
 		if (nr_cpus < 0) {
-- 
2.31.1

