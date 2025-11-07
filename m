Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CED33C51A
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541887; cv=none; b=mHug9tQl2Qeel43/3OkESIwhru5dD6ULvqwhU9zWbmDrwKOxsjfcpkhifmcadrkvwNNmVot5mMf3bntqwYD14+N4wkBL+0m/kqzrAnc24Celx8EMnPDO6zVXN80ygosR7/3j5IHCS94WtobiZLfwUuGyb417M7WmNYrOzz2foJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541887; c=relaxed/simple;
	bh=GTP8xRoJbXJMP0/5uIRzO8chI01OYN025OarFRfFrQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwATf4fYYzhgZe4teDonFbdeJgMrDLIt1ByE6NMZLOnIGMNpL+83EB1k7JgjC0QHIK3HCJxNgZ0ZJcqYEXEEq97Q1MwOOru0HUATIu6cF/nGGnWILJDxKiKhXnamDUIh6aPY0LZfiGBeduKh+1GtTyZ1a7PVOY6DSICt2hiruoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFkSl3dI; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFkSl3dI"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed69197d32so15473751cf.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541884; x=1763146684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fma4HTar02pmQNPFy+BpOxrLCUVOHyGpXcKkbC6fkbU=;
        b=XFkSl3dI0DFIX84peYewfA9KeipvvrxuTogdWj/ae+fusF5FuhE/5sU5VMBGAvc51M
         hSrl66LJVjhUUw1qx+3o8TrdsdJRJWKnh+AFG6qjm1eFJT1Tc4Zqs8/Ai6sU0WPS1ZxY
         1fHn7M+0lCRmy0jv3h4HE5LfQEX7Hkrybs1lWYZBfAw1ki+oxXNbJSegf2xicyzkF11c
         RCteC+CRdfjGJaTRvMzuyIsBJeMbZdz6l+woRlU+va0rwaXlE9+OAyICCMpSZRBYMEDK
         GthB354TRCzWlMN70i7v7IZNfSmrNDfoBuEt0y4KB91Ei/Rii7iiA64/sIT+sBhR2aHo
         s0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541884; x=1763146684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fma4HTar02pmQNPFy+BpOxrLCUVOHyGpXcKkbC6fkbU=;
        b=faow3oXrXfJ3iMVUQmgqlpgS5UGk5TGBtPd219E+f7Ctk3Jj4xhy0Pyj7Kab2Mo0vG
         bdbhELhBkpIY9urCKMWz2tOUj4WR0U2m41GTDJ7JdiY/l/kBEOQspgO1nczdhhfCbHKm
         xjSPoLjX5X+QCvJrm+bEqTomQFaM2nUMlIXPy4AsEHrCZanW6rdwM56A1MfJATnu/b/j
         sPgntUtuLO9IToYBG+KBKtx9C1FbcwARR+/FdwLeA0dIYEq+4J9rPpWs5QQtE+JXEvzb
         u6Ju+LjvFpp/Hz6QEf3PIK0Skjqnc6FcVcWVwWLla7O/djnMSXLeplDufKmc5zbh5taa
         QX7Q==
X-Gm-Message-State: AOJu0YxZU3aQyb+m4zuH+pum4FEzlj3Vvch6/fj+kJ+NkykibP78JiLn
	N3vMLMduKAZ0z/AbzyBBsEWkRcypZSpt+oQsj/nEFGoG+brezdvmuOoxIpWBE17t
X-Gm-Gg: ASbGncvjeBl08+vh4HbnJvQYQbmDw2oqTKHvcMqThxHY+LjI+S3cdxjdOvsR/v0xGN+
	bDN//H1Lt1P2Un+Ec1UFHiaCjl1Hj2WN/Xz8WVwTrJv3Pw2UqlzIETD6C6++6XndyzSviWSec2J
	utmyDXTq8ASMf+loL7wPhCGGMJLNEQSfd08Is3PTWNHLgbFZ7XUk/P1wJM/l56LIkFt9VMrwWHc
	10EPlXbGUHLaFUFuVfBcv8jv07iPN2mmoflrZ+4nFrR4axWFJgkj99Z9Gncsw79xWxZ2hBPVppH
	Noo1tPwvqXQHykkdPxk1CGnAUZXrkVJkF6If/C7MHQTJBbRT470oxGHp31nEGGxDPVcXTobdaGp
	zODS7mAvfrUsy87TmouFrqAJoJZFPkYguNj6HNiljM2PSuL5gaqn5ahaIijReg2yVcZMYyDL8xw
	==
X-Google-Smtp-Source: AGHT+IGuyp/S/DJi7Z/sDizxeE9LVIIpCLjbmfjW0gNENfPvcmrpv2MhapBfxuZthce76BrQ/eB9lw==
X-Received: by 2002:a05:622a:18a6:b0:4ed:6e58:7143 with SMTP id d75a77b69052e-4eda4e73927mr1986661cf.14.1762541884056;
        Fri, 07 Nov 2025 10:58:04 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:03 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 06/23] tuna: help.py
Date: Fri,  7 Nov 2025 13:57:15 -0500
Message-ID: <20251107185732.23992-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107185732.23992-1-jkacur@redhat.com>
References: <20251107185732.23992-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bad indentation in help.py. (Change 8 spaces to 4)

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna/help.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tuna/help.py b/tuna/help.py
index c913a16f4a40..db8b4c84df63 100644
--- a/tuna/help.py
+++ b/tuna/help.py
@@ -4,7 +4,7 @@ _ = gettext.gettext
 
 # gettext_noop
 def N_(s):
-        return s
+    return s
 
 KTHREAD_HELP = {
 'kthreadd':N_('Used to create kernel threads via kthread_create(). It is the parent of all the other kernel threads.'),
-- 
2.51.1

