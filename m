Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE438F8C
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLGpKDTC"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AFCBF
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:30 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7743448d88eso152652185a.2
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617689; x=1697222489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTQdCDMp2eGh/YHKP+c6y3y1Id4XdLtxYettRApfHr0=;
        b=lLGpKDTCNfA2KyeqOdzRUIHzhT+XGrHpzdv4P/qGBPCyUiiZRRluHHVTd7ydPTDLmI
         tHub68om225oZOVwtD85eUG6R3BNWVcIK0V5rR8lT5KZDLvlyK6fFghTaA0zZNMoeh5q
         7aXpKTUXXhd+6F9rB2xNGthZaUFURWFzYZK3kq9rR3EglFjUmyX1U3X37yNyFiCUlNNm
         108wwwCJWFWBRvaFtohumGYeVb8z/m0GMVdUAtSJixJOG6tglZp1EqLvlX0dW3r3np6T
         t+eysZ8duTHGAmLkn9LBIGIUiKTYpBjGqROHUjYVgDjZkFQn0Z0GmtUHj1nh0bMGvrnR
         Btjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617689; x=1697222489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTQdCDMp2eGh/YHKP+c6y3y1Id4XdLtxYettRApfHr0=;
        b=t83ukAFiC5LNn934wjFaW3SFsh1GN5iarzkufv4Gfl/B5pfNqJQ65vC+M2pVBJggjE
         yh7uWAUqfAx8lBL+oFJ1D2cy3TZT8lo/R5xBHNhFtn6uFdSmr5eWD4qD4cwl0aV7aPl+
         SbQYR9xnvQAZPSZY3hU4J9eit1LZ4fuJTJ6rY4gRvV4UiI+TkvrU7QKRcGg5B77l9Ti7
         S/CSKbkL11pkgweos7UU6GLYnKHuvhrRVSWks+BKZgUb+WeKeu57cMv6Qw+hHuJZv5yN
         Lc3wAOB6bP4H/h6aSQ/LVWUNL5/Aa2+m/WQH9HMnZzGgl0IgEBxa9h/rbigxtcI9Vsbi
         2VsQ==
X-Gm-Message-State: AOJu0YzGQNCFOuUpYdu/IVazk1KY5YhsM6/5sqrZg9st7VMkfUcfHkjh
	bdev759cAWtT/g7tI21fkiFhUnAhRL4=
X-Google-Smtp-Source: AGHT+IFVlXiILB3YF8BzFOz99SB7QqtAg4M+6tv8aZXCYKAH6ZPIVETKZsvWqGAtMwOfYsJjqu4u8Q==
X-Received: by 2002:a05:6214:4489:b0:64f:91c2:8440 with SMTP id on9-20020a056214448900b0064f91c28440mr10082268qvb.59.1696617688859;
        Fri, 06 Oct 2023 11:41:28 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:28 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 07/17] rt-tests: pip_stress: Removed unused parameter
Date: Fri,  6 Oct 2023 14:40:01 -0400
Message-Id: <20231006184011.26699-7-jkacur@redhat.com>
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

Removed unused parameter in pip_stress

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/include/pip_stress.h  | 2 +-
 src/pi_tests/pip_stress.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/include/pip_stress.h b/src/include/pip_stress.h
index f03aaf397897..84a7c0ceef7f 100644
--- a/src/include/pip_stress.h
+++ b/src/include/pip_stress.h
@@ -32,7 +32,7 @@ void Pthread_mutex_init(pthread_mutex_t *mutex, pthread_mutexattr_t *attr);
 void Pthread_mutex_lock(pthread_mutex_t *mutex);
 void Pthread_mutex_unlock(pthread_mutex_t *mutex);
 
-void init_shared_pthread_mutex(pthread_mutex_t *mutex, int protocol, int policy);
+void init_shared_pthread_mutex(pthread_mutex_t *mutex, int protocol);
 int set_rt_prio(pid_t pid, int prio, int policy);
 int get_rt_prio(pid_t pid);
 
diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index c6d2bae05035..fb0391bfec0d 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -114,7 +114,7 @@ int main(int argc, char *argv[])
 	mptr += sizeof(pthread_mutex_t);	/* advance the memory pointer */
 
 	/* Initialize our mutex via the resource pointer */
-	init_shared_pthread_mutex(resource, PTHREAD_PRIO_INHERIT, policy);
+	init_shared_pthread_mutex(resource, PTHREAD_PRIO_INHERIT);
 
 	statep = (struct State*)mptr;
 	mptr += sizeof(struct State);
@@ -125,7 +125,7 @@ int main(int argc, char *argv[])
 	mptr += sizeof(pthread_mutex_t);	/* advance the memory pointer */
 
 	/* Initialize our State mutex */
-	init_shared_pthread_mutex(statep->mutex, PTHREAD_PRIO_NONE, policy);
+	init_shared_pthread_mutex(statep->mutex, PTHREAD_PRIO_NONE);
 
 	set_rt_prio(0, prio_min, policy);
 
@@ -323,7 +323,7 @@ void Pthread_mutex_unlock(pthread_mutex_t *mutex)
 	}
 }
 
-void init_shared_pthread_mutex(pthread_mutex_t *mutex, int protocol, int policy)
+void init_shared_pthread_mutex(pthread_mutex_t *mutex, int protocol)
 {
 	pthread_mutexattr_t attr;
 
-- 
2.40.1

