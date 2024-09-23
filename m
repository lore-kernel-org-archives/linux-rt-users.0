Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388368172A
	for <linux-rt-users@vger.kernel.org>; Mon, 23 Sep 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106817; cv=none; b=gXQkckW2+isjOaXScoJiEZttZ2XF5e9Cs6jHHCYlXfCPt4WF8Lu7roZNMsCeIbjVhE/Lzfw46NVO54Oz6ahx+nPTvLDV/lPpoFA8ks4s33vYFZ/bgqrIL7/HIRYtbYkE7CmxZ3/YCjUj8pRtRvGRjf+FUAtHxyLilpTB60ttPMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106817; c=relaxed/simple;
	bh=aBRa/ozWcAYYgVh6o4rf/hSo6wwpAeEasQa+jd+Yj2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lKpJAm36L6cSkcWdOsA35bAGPLRHJqy7vFo0hjocSwhpKh3TAQXceiq+NthTDDxigxCa/BEfLRz31/skBlDTHq2alK1GS0cKj6rYshM5bCm+xak3Do0P2jZwaWu8JYgwnYlr31q7EwAS3hX+zp1pMiTwpEX/OpyKn+WDyNn2gfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBK89CsN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBK89CsN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727106815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kbcB7MIHnPEHRkL356uPQH2kG/assqDn/IhUtVqlOe8=;
	b=cBK89CsN70+wA/gVMhsdUJffA1boadKJDsffVk3eSA0+xiVWxoNDJtsvDtQaQiNTQ2NeUd
	pFuOUn5n3taBFch6L80QINhx+mXD8yyLlRAfXMlbATD3MYshrT0On/DxqcQvfZu4m3yv5t
	XBDvUAuS5wbrMoCHayULdQtb1HBVH3w=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-NPojWopwPfucgway2b9h_A-1; Mon, 23 Sep 2024 11:53:34 -0400
X-MC-Unique: NPojWopwPfucgway2b9h_A-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-20537e42b7aso57121325ad.2
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Sep 2024 08:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106813; x=1727711613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbcB7MIHnPEHRkL356uPQH2kG/assqDn/IhUtVqlOe8=;
        b=VdFAHo1Ajq56vNOrK+eR4c0Qgk1dJhb3A4fMi6czGGL/2aBoT7wGPS4Fv6BLw90+AP
         3TYersywKcjnriIQN+Rx/uhN6RdaUqZoIeVZgRdfzk0vYFT9Sah0/cNTssTHmhTgP/uj
         kvOBshPDToSAOrfoQ4x+FFmrQuOMTI9ALOug5JADzjUcg3cpuO0RzjozjOLUMMoxuzDU
         Epnxc6sGd/l2fPjZEESU5a/hCttLhd3kp0gwSElDHWZayLbeBkjhsS8WoAPoywpzR/L2
         piboBXJpiUYmaP/gpsYiFcSGPAbb7nTC6mH/Y1Cy3A8QFE/wGowtyxJY0hkLdoH6D0yg
         FP+A==
X-Forwarded-Encrypted: i=1; AJvYcCW3dDXyBQum+iYCDO/9yVvIHN3gmPfPloAfdtR+qmZ0hns27ENpunkU4JPM1l/SuuflsQ66gtkumH/iWqRoMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8NNtwf4twonfi4IIo6d7Q7T6wqKf9IPGoO6ywon6Cz39w1CLG
	vZZzXwVecSw77wvFjhTGmebEM9O74GLevVXr+dC5NUs5/g8DRmNQ0b/22NgxHXg9RQc7G8FBzz7
	lFmpiFA26piNcoCLOE8PS3TBFcScNr7APOBRXlBHAoSianjZotJT5xtaLQcoV9Zmx
X-Received: by 2002:a17:902:c412:b0:1fd:9e6e:7c1f with SMTP id d9443c01a7336-208d986dd97mr180388995ad.56.1727106813144;
        Mon, 23 Sep 2024 08:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHTQqv1mff/C/BkMig5wD8imfw3yoe5jVCicINb/XANX9Vx4LXiNrv/kcQs+mfijAWWsj+gA==
X-Received: by 2002:a17:902:c412:b0:1fd:9e6e:7c1f with SMTP id d9443c01a7336-208d986dd97mr180388805ad.56.1727106812889;
        Mon, 23 Sep 2024 08:53:32 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079473d05dsm134321015ad.287.2024.09.23.08.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:53:32 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] rt-tests: Add console_commands.json to gitignore
Date: Mon, 23 Sep 2024 11:53:16 -0400
Message-ID: <20240923155317.43655-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

compile_commands.json is needed to use the LSP functionality in
VSCode, Emacs, and Neovim. It is build specific so add it to the
gitignore.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 9d30878..1fa2677 100644
--- a/.gitignore
+++ b/.gitignore
@@ -47,5 +47,6 @@ rt-tests.spec
 tags
 TAGS
 cscope.*
+compile_commands.json
 src/cyclictest/__pycache__/
 __pycache__/
-- 
2.46.0

