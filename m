Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F62D339B24
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540036; cv=none; b=hZELzPHrvhW14n7GrwZfuS74iLyewKyFVRvaCEU67EGG14Hlwc3p8g6Ys2uWkB93aAUlVZW7nkHjKQNigrNW5Cxbg2Gez4vwLjUGbpn5ygo+XxtI2l6bTCQou02sW7NhCipkCKtsYKu34rZ5KDbujz14HhCiXCHwiRGlJCUsxQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540036; c=relaxed/simple;
	bh=gFwGD7DgAc3gZEjWt7kPAGrbkmrYjwGTB3t1dpKQm5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpK487jMV+aCgISVwhK3T61GFCVOgCG/WFYd4H6qiZCQJOURL5sO9iZngyciOQJtJ6nDe6JVar4Al9T9vi/9V9dfTKTPSNpnPDYc5FkTfZD38QRMF4VOY8Wngznai+HDZrJkMQUDpGRgltDZ43i+soK9V/VrbcurhCycG2nrXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D95wCRpt; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D95wCRpt"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b21fa7b91bso98890985a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540033; x=1763144833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jy27vw8p/gvowZGx68kC91ESiaP+RGwJu3OJkgCiUE=;
        b=D95wCRptd7yRMcPTK5i6FMrqatwJLS7QPODl6+xTTTM4oHfKgfdlCUyzr6im8wZmFY
         hUfx4gDb92VGCfTMKQ/hfVE5tbLf91snNv29/5FQm+r3MFYO0CV1NBY6AjdxnDSdnnVq
         CVBSxnDjSuplT/rD1SsMR1rjKpPox+K73kDUkRDUWgFKDk5OnOxPrsT1I3lo5Sx75gC2
         XXtz+b2eNR1Tk1QE1tZzTN23AOlhMob8ucI6vYxKultihO5TJcpdcvRhFa8Moi46pDfi
         WKrgyNpLa+bYhxxqgkvEjOsmm3aDyzTTLkinnIn260T1CyIUz31ajhOagJxEs7CeTceU
         phkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540033; x=1763144833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jy27vw8p/gvowZGx68kC91ESiaP+RGwJu3OJkgCiUE=;
        b=S9rQ//Haevz4l5ba8la5EK5+7XGJ/b2dhxbr+n5r2/CNBGi2mKxuow9B9CKSJozyvj
         9+ylV7Bfou66iadj6aYmxfLvHdPuf7TXx/uvyaGorm3Bgz/QHqGPwGCEUZl9g9UkxekZ
         q9hf8Vc1qOLCtNpad5SDOqOtETBi+JhUznhD0t1IWlByq1LXxnU+C3sAKBl5Bani46LI
         0qOwDux4r9TitVggjJ0i3ahbhex+v4cgdZo2rDuZYga/tQJnjmrh4oDEbd3Srqmif/Wa
         ksJa5AfUz/ihiaiHkztAE4Cc4MzQY0TmuXapULKbzQUtuoE0HnlrtGjURglQTLjm3OzR
         Hgyg==
X-Gm-Message-State: AOJu0YwDqA6kbJ9xV/HFUt0Yy1XzpxD4tkM0uc5fdTGe+EznyuhU8ECG
	GzIIMNM/EO5m8ySJhFe7/XYar+WUzTJ4eA2bNcACcfjwUtQIYsQGk7QdTzyEy/ts
X-Gm-Gg: ASbGncseoQpcQz/7n61M2bmcF1VFSDXva4f4ZXGq766jJNQseAPxlnTq9aXBM2cmWHY
	8nqhIfLEeTwFXE9d/gBVBmCdl73asyl3avAwWPCWxKqXk+o6adVIyCgrc3RFmP4a+zspAqDcPyN
	so4Yt+ce//r9kFjCqtox0Qcwx3j40DCTOo4A922VPn/f8EUZI81PLXlCl3jDRZ6LaQjDpgtL5o7
	IYUEuUJy0BwS+yaPfnDzrq00nlognNSDAPCRVzZfhA27WsQ+KhUMFChsC6BWRwAYaxnZdgf7IFo
	Wbc8Mw0Db4xGf1VsGmbKUsUFpm2YGNAZYfwTvJ7ps5iTomPRiOlTjfDGHjBbrgPsOPvdbrfT4kH
	rDv5QnErgpGCvOqjkFr5z3TfVXF7Q/Xg6YWAOXBqpfzsPk+84v9k2vE6++0nsOcQ=
X-Google-Smtp-Source: AGHT+IHcvI/xVfT6vVxR9f6yGRVIeRjvxqYfT5wS521J1UfN/UYrInVYdAwrmmdGRARRaGwatjDfpw==
X-Received: by 2002:a05:620a:1913:b0:8b1:be0f:da61 with SMTP id af79cd13be357-8b257ede481mr31816785a.18.1762540032864;
        Fri, 07 Nov 2025 10:27:12 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm452141085a.53.2025.11.07.10.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:27:12 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 06/12] rteval: rtevalConfig: Remove redundant 'is True' comparison
Date: Fri,  7 Nov 2025 13:26:29 -0500
Message-ID: <20251107182645.19545-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107182645.19545-1-jkacur@redhat.com>
References: <20251107182645.19545-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplified boolean check by removing redundant 'is True' comparison.
ConfigParsed() already returns a boolean value.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/rtevalConfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
index 0c2fc6b5761a..e0922c5adda6 100644
--- a/rteval/rtevalConfig.py
+++ b/rteval/rtevalConfig.py
@@ -234,7 +234,7 @@ class rtevalConfig:
             self.__info("no config file")
             return
 
-        if self.ConfigParsed(cfgfile) is True:
+        if self.ConfigParsed(cfgfile):
             # Don't try to reread this file if it's already been parsed
             return
 
-- 
2.51.1

