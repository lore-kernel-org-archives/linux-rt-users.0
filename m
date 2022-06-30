Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BD4CCA473
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jun 2022 22:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiF3WdR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiF3WdO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Jun 2022 18:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79BC495B2
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2022 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656628392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7KwLoH0d9jahqdN5gAGjp/0Ed77DbKf9u/QbOUdSiM=;
        b=Fiyl4c2s7/FCV48b4uOvCcf8+ZfNkTo/qlHCcleoc8Zt2q3KbHpTXDEK2Rub/IpwBmloE4
        h4I9jjzzmOFiVpyJzYGAkQY0ObODGibWKlqGxQ46rQs0HRy2v05ClwiXGt6cuQ8ISYfGHP
        8ng2X2m7HjDwATBs0u7e49AY0xymL5o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-b2BlMoQLPHGIylIgghOlIg-1; Thu, 30 Jun 2022 18:33:11 -0400
X-MC-Unique: b2BlMoQLPHGIylIgghOlIg-1
Received: by mail-wm1-f71.google.com with SMTP id h125-20020a1c2183000000b003a0374f1eb8so2051213wmh.8
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2022 15:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M7KwLoH0d9jahqdN5gAGjp/0Ed77DbKf9u/QbOUdSiM=;
        b=vP0fAzLtXD9zxIIC+KtXOjIAfe3fXgCLkyzCa+9lHv2Q6SF0zTZ6wWySubVeQ8S5yW
         urcW4kzu1/u83LHIkLNPQRu0fIRE+qop+khj2Z1ZRB6Vwl8YlColDoDKHLZdVVc4QVk0
         G/Mg5svnqCnzjd3RyuaA9QnFa9Bfo82HAKXJUmbUcx4e3wvuRCPOK+wySqtMgkFXaODX
         MHKDUJHrgsUpsb09HENsVKmHfI1+EaGmXqtb3k9mK24Dg7kkC4t91Z425rlXWTNX5o1a
         rJBC7tKgEmaxIMuQnrGAXlh47GyOy3aTS2HOsRHhuCAOA/HiXWgpXmlqL/AFow8DA6eJ
         X30w==
X-Gm-Message-State: AJIora+NWz3YFepMA2sW/F/9TYEGAJq3sdxWNeWR95AQEbC8kD96QGP6
        EWzDdOEaMbKHReFScvZGAuqkU9pLXqwou36Q6n8870RerRDO2tLO4dZCYYbR7LysBwuekaVaWMe
        xekQGHhQEdERrUNg9oXyoWIpHLHc=
X-Received: by 2002:a05:600c:2049:b0:3a0:536b:c01b with SMTP id p9-20020a05600c204900b003a0536bc01bmr12804846wmg.151.1656628389748;
        Thu, 30 Jun 2022 15:33:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s0NtFXC0FlUaliXhCXoOcENAR69+spVwYicuXfWxSDj9OAt+BI6mrAcCGFYu+NNT4zLgABNw==
X-Received: by 2002:a05:600c:2049:b0:3a0:536b:c01b with SMTP id p9-20020a05600c204900b003a0536bc01bmr12804822wmg.151.1656628389367;
        Thu, 30 Jun 2022 15:33:09 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b0020c5253d907sm4308387wrz.83.2022.06.30.15.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:33:08 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v4 1/2] kexec: Turn all kexec_mutex acquisitions into trylocks
Date:   Thu, 30 Jun 2022 23:32:57 +0100
Message-Id: <20220630223258.4144112-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220630223258.4144112-1-vschneid@redhat.com>
References: <20220630223258.4144112-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Most acquistions of kexec_mutex are done via mutex_trylock() - those were a
direct "translation" from:

  8c5a1cf0ad3a ("kexec: use a mutex for locking rather than xchg()")

there has however been two additions since then that use mutex_lock():
crash_get_memory_size() and crash_shrink_memory().

A later commit will replace said mutex with an atomic variable, and locking
operations will become atomic_cmpxchg(). Rather than having those
mutex_lock() become while (atomic_cmpxchg(&lock, 0, 1)), turn them into
trylocks that can return -EBUSY on acquisition failure.

This does halve the printable size of the crash kernel, but that's still
neighbouring 2G for 32bit kernels which should be ample enough.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/kexec.h |  2 +-
 kernel/kexec_core.c   | 12 ++++++++----
 kernel/ksysfs.c       |  7 ++++++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..54d7030d3c41 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -390,7 +390,7 @@ extern int kexec_load_disabled;
 extern bool kexec_in_progress;
 
 int crash_shrink_memory(unsigned long new_size);
-size_t crash_get_memory_size(void);
+ssize_t crash_get_memory_size(void);
 void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
 
 void arch_kexec_protect_crashkres(void);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce..16370926b21a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1009,13 +1009,16 @@ void crash_kexec(struct pt_regs *regs)
 	}
 }
 
-size_t crash_get_memory_size(void)
+ssize_t crash_get_memory_size(void)
 {
-	size_t size = 0;
+	ssize_t size = 0;
+
+	if (!mutex_trylock(&kexec_mutex))
+		return -EBUSY;
 
-	mutex_lock(&kexec_mutex);
 	if (crashk_res.end != crashk_res.start)
 		size = resource_size(&crashk_res);
+
 	mutex_unlock(&kexec_mutex);
 	return size;
 }
@@ -1036,7 +1039,8 @@ int crash_shrink_memory(unsigned long new_size)
 	unsigned long old_size;
 	struct resource *ram_res;
 
-	mutex_lock(&kexec_mutex);
+	if (!mutex_trylock(&kexec_mutex))
+		return -EBUSY;
 
 	if (kexec_crash_image) {
 		ret = -ENOENT;
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index b1292a57c2a5..65dba9076f31 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -105,7 +105,12 @@ KERNEL_ATTR_RO(kexec_crash_loaded);
 static ssize_t kexec_crash_size_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%zu\n", crash_get_memory_size());
+	ssize_t size = crash_get_memory_size();
+
+	if (size < 0)
+		return size;
+
+	return sprintf(buf, "%zd\n", size);
 }
 static ssize_t kexec_crash_size_store(struct kobject *kobj,
 				   struct kobj_attribute *attr,
-- 
2.31.1

