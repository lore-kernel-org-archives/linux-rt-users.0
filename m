Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28568C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 23 Mar 2022 14:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244941AbiCWO5o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244934AbiCWO5k (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Mar 2022 10:57:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFCC7DE24
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Mar 2022 07:56:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id yy13so3392791ejb.2
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Mar 2022 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xxpZ0iiJJ0ZwZEvYkcJ55MAH2/mjQ7Nkl8lEGJi9pe8=;
        b=LABB1GCxIPlD3luxLyc/Nvl+Hx/y317qPwHAgq23XvnHF9qpUBg7Oj4qKR9m2oKy9Z
         nLHPjFsSVxbqnfMNTml3G5XFtYhv8f8ntalWyDLPzFpp/dHrB+gFda+AuFQOaMhvDpOG
         lVJ8tx+kfAFLsN1d7jnDqXAnP4HnCw5VLTupQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xxpZ0iiJJ0ZwZEvYkcJ55MAH2/mjQ7Nkl8lEGJi9pe8=;
        b=H0059s8Lvyf49ajyGUvnMWhWP+EcS/8v0C+Wcn4EW68JG8NuN5q2gYrQJt8DPaCo3j
         dYnF3tfMfxxKT28SDGlVVjYtM219YPZLF4VFatFoBh/eYwS9Af9KHnnTOtJEKhIMtUI4
         baaHJ4uKmZXz3vOuPVk8W0afubq7RTP5SruLY6OJT6aEmNCaF0rpBqTWABzJJ2rPf6Bc
         PIvb9oCesq1oe2RuLego18poaiujgiOyDtLwUvZrjlZKzIriP862vtWHs+H/6iLvjgn4
         uUXhi9+YEMV7hCxhG4ls6fmgGvs8RI0fRxa42Hjq8Uq1ZcAm9e5tvNLz1INVJgDfq9k5
         u3aQ==
X-Gm-Message-State: AOAM530rAsfE1H3cJs+cxvhL4TjGgs2MH7rPEmFCwnjwXhziyrWGQ5k7
        X2oIiN3o22by3kts14VPHAxbGQ==
X-Google-Smtp-Source: ABdhPJyFFyzCsMB02alxju10p2mtcDMblMiJlaXPaFNhnOhkRjAQ/fDW1gf6qTgwYf+nZz7WQmnLzQ==
X-Received: by 2002:a17:906:57c1:b0:6d6:da73:e9c0 with SMTP id u1-20020a17090657c100b006d6da73e9c0mr363734ejr.45.1648047369103;
        Wed, 23 Mar 2022 07:56:09 -0700 (PDT)
Received: from prevas-ravi.tritech.se ([80.208.64.233])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640210ce00b00413211746d4sm77256edu.51.2022.03.23.07.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:56:08 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     =?UTF-8?q?Andr=C3=A9=20Pribil?= <a.pribil@beck-ipc.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Esben Haabendal <esben@geanix.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-rt-users@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] workqueue: update sysfs handlers, allow setting RT policies
Date:   Wed, 23 Mar 2022 15:56:00 +0100
Message-Id: <20220323145600.2156689-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
References: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

For this POC, this (ab)uses the "nice" attribute.

It's of course not exactly pretty, but it avoids the problem of "what
to show in the xyz file when using SCHED_NORMAL, and what to show in
the nice file when using SCHED_RR/SCHED_FIFO".

It's backwards-compatible, in that a bare integer is interpreted as a
nice value, while an integer prefixed by "fifo:" or "rr:" chooses that
RT scheduling policy with the associated value as the priority. The
show method of course reflects what the store method accepts.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/workqueue.c | 54 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9eb2ff7bcc04..a97f1aff809e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5538,13 +5538,34 @@ static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct workqueue_struct *wq = dev_to_wq(dev);
-	int written;
+	struct workqueue_attrs *wqattrs;
+	const char *pfx;
+	int val;
 
 	mutex_lock(&wq->mutex);
-	written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->unbound_attrs->nice);
+	wqattrs = wq->unbound_attrs;
+	switch (wqattrs->policy) {
+	case SCHED_NORMAL:
+		pfx = "";
+		val = wqattrs->nice;
+		break;
+	case SCHED_FIFO:
+		pfx = "fifo:";
+		val = wqattrs->priority;
+		break;
+	case SCHED_RR:
+		pfx = "rr:";
+		val = wqattrs->priority;
+		break;
+	default:
+		/* Shouldn't happen. */
+		pfx = NULL;
+	}
 	mutex_unlock(&wq->mutex);
 
-	return written;
+	if (!pfx)
+		return -EIO;
+	return scnprintf(buf, PAGE_SIZE, "%s%d\n", pfx, val);
 }
 
 /* prepare workqueue_attrs for sysfs store operations */
@@ -5568,6 +5589,24 @@ static ssize_t wq_nice_store(struct device *dev, struct device_attribute *attr,
 	struct workqueue_struct *wq = dev_to_wq(dev);
 	struct workqueue_attrs *attrs;
 	int ret = -ENOMEM;
+	int policy, val;
+
+	if (sscanf(buf, "fifo:%d", &val) == 1)
+		policy = SCHED_FIFO;
+	else if (sscanf(buf, "rr:%d", &val) == 1)
+		policy = SCHED_RR;
+	else if (sscanf(buf, "%d", &val) == 1)
+		policy = SCHED_NORMAL;
+	else
+		return -EINVAL;
+
+	if (policy == SCHED_NORMAL) {
+		if (val < MIN_NICE || val > MAX_NICE)
+			return -EINVAL;
+	} else {
+		if (val <= 0 || val >= MAX_RT_PRIO)
+			return -EINVAL;
+	}
 
 	apply_wqattrs_lock();
 
@@ -5575,11 +5614,12 @@ static ssize_t wq_nice_store(struct device *dev, struct device_attribute *attr,
 	if (!attrs)
 		goto out_unlock;
 
-	if (sscanf(buf, "%d", &attrs->nice) == 1 &&
-	    attrs->nice >= MIN_NICE && attrs->nice <= MAX_NICE)
-		ret = apply_workqueue_attrs_locked(wq, attrs);
+	attrs->policy = policy;
+	if (policy == SCHED_NORMAL)
+		attrs->nice = val;
 	else
-		ret = -EINVAL;
+		attrs->priority = val;
+	ret = apply_workqueue_attrs_locked(wq, attrs);
 
 out_unlock:
 	apply_wqattrs_unlock();
-- 
2.31.1

