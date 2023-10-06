Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D95838BBA
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwrOCFLo"
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8304CC6
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:39 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-65b0ffbf36aso13292896d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617698; x=1697222498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QLR26rEtIFIAqvZnRPWYEJYvQEnm0B/eNDbZ+pM48w=;
        b=IwrOCFLoGZV+/AQCOxrelPni2yi3CsJ+Me6rj8e0e18HFrcuUONyJ/UrqWXjGDOkZg
         +LsqbGVLX5Y742XUDYxzGzhqZ+4diltRwSY87DP0zZ8q7OiRNlesfCUD8Z2Bv/qsaTzo
         30jNraysjQFqpp5PuuCCY8TZ8uwiAGBfKnrKZGZgOSWDj9uvxgqs0QHQqn8ot20YZzPx
         5wTzWel43uDkZoAXoXOwhIzmyR93ZzyPd+L56Vio1b0lOxdUzeYx0ROLJClOTXcXlc+9
         vKgNPH6FkvM4Xpa/P12Ht1HYqhSnLblPi0rbJCearrTq/Qa30L20muMcqvfVAsUG1D5l
         PLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617698; x=1697222498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+QLR26rEtIFIAqvZnRPWYEJYvQEnm0B/eNDbZ+pM48w=;
        b=tcgMlwz6/WgeoknPa9kbAYAP+d4wkje0FaXMEIVRhKRS+G8LhKR5xq93KrkLIGxN6p
         SCrkrL3aB7rWwtyggXyR833YXmBt8WOs0JmpvlZlkz3+vhhkAVHHE+JZ3AU/83mQoBPw
         JlkitjptlTf7bMdOohye65qcTOTdZxin9TFpqPN25/jBK5sgzA813GhxLonelcb9fGzx
         nU8mSu+edKYYSJqMOEja3hCzflLl8XwLt/Zw3WYknVr4p/YmOjnfISa7mcNxjk3VS5LL
         KFDLTquV86TZduc47JK76rarG+r/FXgNcGQRYT8Dk4AiQ2Q/47BSBTvUdO6HiX/oOEDF
         yxlQ==
X-Gm-Message-State: AOJu0YxPn8IHNnOmDBK+qYQnqj5Avx2c5pDJv3uQcXzWHaBvRYuIfSr2
	YCFZklT945uK45U6637jQS70nKp5IWM=
X-Google-Smtp-Source: AGHT+IGVHxoF1+eGqr3nuvBj7sSJH5BIlGLOWGV8VZEftFyO7NfDm/SilkdpHP+zSc+IOvDXWNqwjA==
X-Received: by 2002:a05:6214:5b0c:b0:65b:15bf:4f13 with SMTP id ma12-20020a0562145b0c00b0065b15bf4f13mr8520433qvb.65.1696617698211;
        Fri, 06 Oct 2023 11:41:38 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:37 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 16/17] rt-tests: pmqtest: Fix various warnings
Date: Fri,  6 Oct 2023 14:40:10 -0400
Message-Id: <20231006184011.26699-16-jkacur@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184011.26699-1-jkacur@redhat.com>
References: <20231006184011.26699-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix unused parameter warnings
Fix comparison of integer expressions of different signedness

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pmqtest/pmqtest.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 9e142787d8b4..b21dfa0fe0cc 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -418,13 +418,14 @@ static void process_options(int argc, char *argv[])
 
 static int volatile shutdown;
 
-static void sighand(int sig)
+static void sighand(int sig __attribute__ ((unused)))
 {
 	shutdown = 1;
 }
 
-static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
-		       int verbose, int quiet)
+static void print_stat(FILE *fp __attribute__ ((unused)),
+		       struct params *receiver, struct params *sender,
+		       int verbose __attribute__ ((unused)), int quiet)
 {
 	int i;
 
@@ -456,7 +457,7 @@ static void write_stats(FILE *f, void *data)
 {
 	struct params_stats *ps = data;
 	struct params *s, *r;
-	unsigned int i;
+	int i;
 
 	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
 	fprintf(f, "  \"thread\": {\n");
-- 
2.40.1

