Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691338F93
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhIYSyT0"
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A9FB6
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:30 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c7bbfb7a73so1598696a34.3
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617690; x=1697222490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faJ/gIIDuCFQlxulFEiad3gDSOvV+m0iud/HQw9l73E=;
        b=MhIYSyT0ZlvJ1606HEHdE/8x/oLrbG4wJh5Inu527oxC/1vIdkUkMvLZGiqZT/7U1V
         eRBvb5MIzhRU3VUr1zaERlJCH38OkOKNhiO3yJaTreTQR6VZB2xiPvmqtVbOo4WWRquF
         9qnU70UsEZkYp/EYmGSh1xr/TWXfLi43OHgXQPtE2nmqXJTzvuSVONEMa1qwFb2bNqa7
         HmsGlX5yHxQQTbJkSX2Aq1OtdMSjA38IIIi/75BW62vo9uX9DfWRLFK9+N8K4EQAgKt0
         xmDwZo+1nW4OHn1SqhGv542UetPUnKTAQ9jMjT59B2w4ZfLYmqV3kiW9Jnzpdtb4EXYl
         qRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617690; x=1697222490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=faJ/gIIDuCFQlxulFEiad3gDSOvV+m0iud/HQw9l73E=;
        b=foP1iQsdG47bvxc55LhoBZN3+hyOkmNNpkSEKOhTmZC+zCQ6Iamm+Xvl37uCzBTav8
         rv8/GpgL1FQ+2nWTp9ZoHRJEbCtMIBgYZdaWABYfzJtbzbvqRiVyKIpuzdYMiKkq7ZJL
         9bjniPl2v4ffOfnM8VEX4x/PeGqhincQDOpMY4CdqPiqMB7eJqesaQL0ORO0sEAa+cBM
         9xKGVDTntk3DMAvbXWxp2GPHotFgMq6M1eyMetbFCV+HhNhmnTLzfszg8OCykddoPAL9
         GCnlHTlbZ+ACV5KDEmmE/ktj4DsSADl/n5jMZBFBiDADHQKnyPKS00Pn+A0vKouLBn0G
         9lmw==
X-Gm-Message-State: AOJu0YwdUe8LN3ii1LONttWsFLJ1tEK8BTHeDWoNBZ97RCYfDd12K71n
	SJe7W5rpIXVkFpAUOua8k6b9einOgB8=
X-Google-Smtp-Source: AGHT+IFa7DLhcrxNhzS1+QO/ku8WOk5AyL2QEjLsvY2PBKzG17+crgeyGRUqtzIsgKw8NAIOilhoTg==
X-Received: by 2002:a05:6870:ac1f:b0:1b3:8d35:c85f with SMTP id kw31-20020a056870ac1f00b001b38d35c85fmr9853191oab.1.1696617689737;
        Fri, 06 Oct 2023 11:41:29 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:29 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 08/17] rt-tests: sigwaittest: Fix some warnings
Date: Fri,  6 Oct 2023 14:40:02 -0400
Message-Id: <20231006184011.26699-8-jkacur@redhat.com>
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

Fix some warnings about unused parameters and comparisons of integers of
different signedness

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sigwaittest/sigwaittest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 728176a0b385..818e3a8e680a 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -384,13 +384,13 @@ static void process_options(int argc, char *argv[])
 
 static int volatile mustshutdown;
 
-static void sighand(int sig)
+static void sighand(int sig __attribute__ ((unused)))
 {
 	mustshutdown = 1;
 }
 
 static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
-		       int verbose, int quiet)
+		       int verbose __attribute__ ((unused)), int quiet)
 {
 	int i;
 
@@ -435,7 +435,7 @@ static void write_stats(FILE *f, void *data)
 {
 	struct params_stats *ps = data;
 	struct params *s, *r;
-	unsigned int i;
+	int i;
 
 	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
 	fprintf(f, "  \"thread\": {\n");
-- 
2.40.1

