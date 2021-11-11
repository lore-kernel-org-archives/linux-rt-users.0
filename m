Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CBBC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403C36120D
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhKKUpb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbhKKUpa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:30 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31411C061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:41 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id q14so6480604qtx.10
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j1Bjm9LGNJ0lss9AUejzAXMP0Duge/HkYKVBRf0TB2A=;
        b=UujVxwU0blvCSHN0ooPUyXEwIqEWMB3xlarLrJQ0YBfvKgj0LBSbjkIg+kBbYNcwSX
         iwZFyDv5YtjaVHmD9TP6B7kWjhKbvMacF4lONjllYzJI0YwRVNRYez5mVCxjVSjoimkW
         Q/GktaCFV2FbAgASAA3tSs/oQw5TWu8UB7kHRi1anNqdnu9BWrpjDj+3uMMAmlRHs5D+
         lceHWm7ccgtpyfskS9SdOvWFxsuGj4KXPX4KP3JYERMYSKm1Jg68oqSZSI7ikMAcot3G
         rtsjlmtYxtnEhDEkwbzXthMT9sgLQQgpAqcDPr91irZcVRcvzxJ/FNhxLVKAh0cunJQv
         NdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=j1Bjm9LGNJ0lss9AUejzAXMP0Duge/HkYKVBRf0TB2A=;
        b=UTvHVEiHrZjYzCxlwl7HFo0pGNdeHg2OUhaNsbJN23+MRiF4SJ9Ge8aNZKyCGNBfnW
         vQ2unwD8eQE7W+GL3EGDT2OWUsRknB1ex7v5Om4XJooZSI7FIK/Ijrbj7eD/vVQXLxsF
         Xlu86VN9EKUswKoQgNNbbVGZxkyj45ol/a9kM2KKCRrxvS3HwnYA3tiAuhS2BiKKu+t9
         2Jew+f+ixBlnKMtXGcYhi0tXgGtFN6KW7ZI6MnouC830TCEKjd33jgiF5P7Xn0/5JapI
         wr5HTOh8rj9MYkBsnEY3VTJzJV5sJgBpCwiTtliMYSveg8kQQG5hQB2SdhBKw9Qs5RpK
         eeWQ==
X-Gm-Message-State: AOAM533menVuGauJ5vWDTKWwZKdvLH4QccE13GUc0+WuhOLKujzYaqcy
        XpZiwo91aHWlHcx2cHjO2tdav2VmNmg=
X-Google-Smtp-Source: ABdhPJzJBy2Xz0mUzv/aK4WhcvosHbswQaaghlYQyEvQY9EJSkKsy8RBP48Z8/lfEF2roQQfrWoQgQ==
X-Received: by 2002:a05:622a:1491:: with SMTP id t17mr10611698qtx.402.1636663360106;
        Thu, 11 Nov 2021 12:42:40 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:39 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 17/17] rt-tests: cyclictest: Drop unnecessary variable "bufsize"
Date:   Thu, 11 Nov 2021 15:42:07 -0500
Message-Id: <20211111204207.10167-17-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

Two copies of "bufsize", initialised with the same value are declared
in enclosed blocks. Remove the redundant declaration.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 73c5be972391..490aedb54c03 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -2059,7 +2059,6 @@ int main(int argc, char **argv)
 			memset(stat->values, 0, bufsize);
 			par->bufmsk = VALBUF_SIZE - 1;
 			if (smi) {
-				int bufsize = VALBUF_SIZE * sizeof(long);
 				stat->smis = threadalloc(bufsize, node);
 				if (!stat->smis)
 					goto outall;
-- 
2.31.1

