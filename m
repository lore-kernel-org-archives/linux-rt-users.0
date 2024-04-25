Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681714E2F6
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Apr 2024 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068464; cv=none; b=nTGKAF66lc+6bDGOG0o5CeKYVGYVBjyoNGAgqLFEEWZcDfT3+gBKM8By7uMI5RwlO913DE9jHRwOj6eGRKfBfoPgOFguDoxtHHVLr38CCHQkibLLR+pOvsCYPphSRFuOXAlE9HsVsmWxIOyTlH9vlEY1qmmOh+jJq/mcH1TkiU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068464; c=relaxed/simple;
	bh=CM4B9+qAcVnI1XV7OjqRTibeaaRJbsi3N9KI0NnrpgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaz0eYwCIbi9PkAslDAyLTf596RcPtD17Ok/FWdkt645h1NrZBILEf6YcBm9j8Q5YMnx4nAba0qEnB2ZoGtKB7UneEj2T2jkTPIkkJAUIVgfC5YorHD0LZEd3rd45ULY63Sx1iFVFiIGvBwkXMw6NjnkGcjpnEaD9LbpnpgX6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu32wi54; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu32wi54"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69b40061bbeso7595346d6.1
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Apr 2024 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714068462; x=1714673262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viEwlfKmx8SecYACMb9XiSoxhLtdQcPbWOh7hUeOi4w=;
        b=lu32wi54RtYm3cp3wkFrSPomXJikDg0YipR4+zqgDVor2SWH7U74pcTAaOXKDLS9NW
         EQSge164N87klix/mmKORAI3h5U/sn0hDqz5jXJgu+gMW0gSz/S0GBUewxP/F1xI3x63
         ZWDLw2ISooWJj8xk1hlyJCzAMAUiZqzddznRBcoJUpV1qhDdP0Ruoz+NicmpKBbOUTpR
         46ZmZezxXsDg8NPD68ctaLCRTnO+J241zu8CJ+79kxvKsxbpWJF8FIbWZhWpmtEXNB/8
         hGk//6cX4ld7GoBJoPewF8CzXdE38b37nIFnLEsxm11asLcTf5EjA81WK8iHZO3Mthh4
         fc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068462; x=1714673262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=viEwlfKmx8SecYACMb9XiSoxhLtdQcPbWOh7hUeOi4w=;
        b=Dg9RlSYARiMGumQy3+GOmjMeS6SlTTomT6HmHuoenxk+T4gRB2CQLHFrMlUmL915Cp
         zIvaYnkfXGX3cVP0bURj8Hw1yqvpvJkb1gFEe7lFh/vCCTOu5bgAwXxX75faut7wdM7g
         vuByGmhy1xPxBBuryHeV5XxiP9zqvaN0cZh+2ahY4wgvKbBh2v/R9YrlbTOj6D9wS3OK
         GLjXdt7tWrpbSwlyVVRSD3yMxiJMHELsZ+r2RDnwESd+wo+MVFbFl6bPFt41kWuLOmml
         g7EjKLEnk6x5FXUk6oqGds1/fssdQmhhQa0+MFeWzYgrFboLVNqBeKZLJ2rCQVlwpW5z
         7cpA==
X-Gm-Message-State: AOJu0YzhrVGtpRT0hMfrjj4wPWDBfxOk9y2vqgHck81QTAnDAe3EnZIw
	iCciiWiBnqVVxKZMRjrik0Yj9YP08MUi86+d4YQ4rrJh0ZHbYzk/5xtEIQ==
X-Google-Smtp-Source: AGHT+IH8ZuvJtK/ST8iLs6BiJhDlge3TZYGjy2jegPNRMOMldgeDhXyK39TXmEL0WYwZbfudZQDsCw==
X-Received: by 2002:a05:6214:29e9:b0:69b:5ecd:7c9a with SMTP id jv9-20020a05621429e900b0069b5ecd7c9amr595685qvb.51.1714068461503;
        Thu, 25 Apr 2024 11:07:41 -0700 (PDT)
Received: from fionn.redhat.com ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id n5-20020a0cdc85000000b0069b7c8ced6asm2103931qvk.12.2024.04.25.11.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 11:07:40 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Daniel Bristot de Oliveria <bristot@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/4] rteval: cyclictest.py: Remove unused method sample
Date: Thu, 25 Apr 2024 14:07:21 -0400
Message-ID: <20240425180723.66499-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425180723.66499-1-jkacur@redhat.com>
References: <20240425180723.66499-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the unused method sample() in class RunData

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 48b86a03cbfc..1ba8b8b2323c 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -61,12 +61,6 @@ class RunData:
         if value < self.__min:
             self.__min = value
 
-    def sample(self, value):
-        self.__samples[value] += self.__samples.setdefault(value, 0) + 1
-        self.update_max(value)
-        self.update_min(value)
-        self.__numsamples += 1
-
     def bucket(self, index, value):
         self.__samples[index] = self.__samples.setdefault(index, 0) + value
         if value:
-- 
2.44.0

