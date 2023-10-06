Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9738F90
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhqEHdts"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF73BC6
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:32 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7757f2d3956so284249885a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617691; x=1697222491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDu6Sfswb11ARYZoMqH8HTJCnPB9TedWeBm7Ujx2mm4=;
        b=PhqEHdtsrAV0DUcn2CY0DjV8w5/CBQrEo64swJtlXH9u4VbcwdrVm//TT7/5wmmfi/
         A8di2XFGc6Og1Tj+xFBjTojXpVUtWcAbTUd3GjIM3w82sNwNNp18E7pgDrd74AIjbPGn
         2qWSpfkQriEruymYGpnCDYcprQNQqzmm+8t8n0Zf14baBJ5fgRKwCYxC2J9D13hX9U9j
         AIvLSsH94qsX/OVbFchVb9s1Z2oHMoboRUAJ5N0hii7VxJj4R3X2u/N9aoqWvKu83NXL
         q/6fjAkvHGQxjuKlytZh7iO32rdJ55wJFWLTy0BXPhyJcAcVDNMZwUb2nrCauZpmQ1lU
         owUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617691; x=1697222491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MDu6Sfswb11ARYZoMqH8HTJCnPB9TedWeBm7Ujx2mm4=;
        b=wUGOTUO15L/bWh6sAiJTLYwJ5BX2ftYG2hRc4RCW01Q31GsznKXt72hLTkt0l8fniQ
         pRtICB/1p8F6optoxpVa/LjgVSbnb+VEqQ5V6y/n4bgyGGmYslTQmGBhwwSagpA/TUOa
         OXT4eWDdFPTJ0Sire7CwAEaxIjSNj2X0Y31834DJlneeLFFGqPsi4/eYK/4J0hL8JvYC
         EYVQBwfvYXkEl5xLCiE7RjwHS4zg4eeVrjl18OD0BGIfyMcgflJVPCO9pf1e+H1QOltF
         z+jhIgwHfebLbqJZR+qUUgR5RVqCJAmBQYwB2+ufVr04xhYL52fBQz3ePfqKW22eXQxA
         Civg==
X-Gm-Message-State: AOJu0YwdCpsYu25O8suXwxjz7CVxFvwYANyvzP3upkAW4hZe07N91Bhc
	pXNJwf0CDPuwlsQr8F+a/xcM0NXGK4g=
X-Google-Smtp-Source: AGHT+IFrP+22tKv1/wQuxmyHRzCjGsilhB7kRRIEjKVwhL/mOmcXq120FMWv8cOVw3VBztX3Wo7wKA==
X-Received: by 2002:a0c:f5c4:0:b0:656:3fd8:bc75 with SMTP id q4-20020a0cf5c4000000b006563fd8bc75mr8338199qvm.6.1696617691641;
        Fri, 06 Oct 2023 11:41:31 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:31 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 10/17] rt-tests: signaltest Fix unused parameter warning
Date: Fri,  6 Oct 2023 14:40:04 -0400
Message-Id: <20231006184011.26699-10-jkacur@redhat.com>
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

Fix unused parameter warning in signal handler

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/signaltest/signaltest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 1cf03931b5bf..4737c253b1af 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -357,7 +357,7 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 	}
 }
 
-static void sighand(int sig)
+static void sighand(int sig __attribute__ ((unused)))
 {
 	shutdown = 1;
 }
@@ -388,7 +388,7 @@ static void write_stats(FILE *f, void *data)
 {
 	struct thread_param *par = data;
 	struct thread_stat *s;
-	unsigned int i;
+	int i;
 
 	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
 	fprintf(f, "  \"thread\": {\n");
-- 
2.40.1

