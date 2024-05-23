Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38F52C684;
	Thu, 23 May 2024 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480293; cv=none; b=Q2vX0W/ssKpY1JaC0VFbBNyHMnkWxyyyWDKHUMk25hFdkfcdmJIRLl+u+C8Mb9CMRRdScBXLiz05ik/dFuneh+1Xb3yMXJVXdxL52ZbEWRZ5z+U2Nc5Gl3Pxv5X/Jg2U9Ku34tnJW1lTzrSZCxKQKnoLjTopNgkXqXUDfEShEfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480293; c=relaxed/simple;
	bh=HZ9RonlrBTgQKUksO/V8zol27bXAiWM7tEzfNGOp3Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GkWu5lAndr0vb5051fF2kpzQwSkM7T616O387t+9QytTXqgKEtYELLNLoD4pMltrbjPuIN8V/OnqBlxc3zobuMimOu6g8j3H+SCsrTMRlyQJh8acM63JcoWHuImMUtQ//UDi6fUH5vgYQN6iE0H/0hcwGk8mRfCeLl/ns3LzbSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fnmmv6dj; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fnmmv6dj"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1f32448e8fbso15183875ad.1;
        Thu, 23 May 2024 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716480292; x=1717085092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZ9RonlrBTgQKUksO/V8zol27bXAiWM7tEzfNGOp3Zk=;
        b=Fnmmv6djqxgeBwhbOaVy2qS7HMHs5DWbVK4MEHhXgCSYm1gi72WBGRbVSih7uyT5Cp
         Xc3dGrefFcuRZkvsJChbAuk/Sh/njln6V8RSOrWZStqS3LbzTtMN/649YDOi4kA44EW2
         uwWZW15DAwkZ0lyEBlKGFg/1hIGF+f/j2wNo9EKe7xfR/KlMOXKpXOZkNfG+un9YC6IC
         hayRLh10wg7itU93l/G1z/wyWOA28kHMfZOE7hZ/AoH3Udd8UiUHJ7xTRrpcpHWqPVHZ
         U0RNAN0HyaqBGFbtWvP83AX+55tAHmqXPlmN4YREjbOAjNfCe4+0ZdhCJ5Nf5L+6IXOY
         F8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716480292; x=1717085092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZ9RonlrBTgQKUksO/V8zol27bXAiWM7tEzfNGOp3Zk=;
        b=wL9XKOUscVLC8TWc15tyU+zFynI3srpdQhEvNgbsTZQiUKPcrvU35UuYkFO9Eh9yh+
         EN8MplRfBnYN2v6dGc8jspqUue6p6G13Q83A38CWugyQqGFgMWZQwevkRA4FHYjyHgnN
         rzRl6vvA2p9kAn3iMBl2u3KZG1669+YOOpOhSiFrEXG8Uas0YCb9oNQR+jlljHrjw+rw
         aG34mK6Q8cmjWcBR6oAKUuGRcSZbZO6PAEPqqK0v6SlzDhf23jye7PwVQ223DJkJ3U0i
         ebDvemM3z7GJXauC4eMbruYIWvJrPfC7FXhvpaRQT9+fbreNF/ibKGwaxFdWWSIQMrQX
         5T9w==
X-Forwarded-Encrypted: i=1; AJvYcCVs/1wfkLN81TPbC2iw2S6+rdOAN+apnnSaJeelN/wmJafik3ZqChAYu7ox+Ow/JNhGsOJeDtQ75FQNM0ctES/467oBtMKn8QFGfAQFunPEgB1lU4hYDtorHRRqus7btk8uOddE4JiTiJqe8Sw=
X-Gm-Message-State: AOJu0Yy50/JC8gAd6Erf3le3mGuptY9CzM2DcNd8YLMJoXEYSdKgKp0S
	/19uB0D8mbCjytyfY/FXN1sVmJCO6t9ks8AKphcHhhQP8b1uoi8TBW0ePZRB
X-Google-Smtp-Source: AGHT+IFnmgQnffQWlozSlFnHpvCn9HYz0suB5yGves8e6JydYfSSoqwXqttah3ztzfXPm41ybSfsdg==
X-Received: by 2002:a17:902:db07:b0:1f3:3d07:d6e3 with SMTP id d9443c01a7336-1f33d07d86cmr25200585ad.34.1716480291813;
        Thu, 23 May 2024 09:04:51 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f32695c45fsm31086895ad.92.2024.05.23.09.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:04:51 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: xu.xin16@zte.com.cn
Cc: bigeasy@linutronix.de,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	liu.chun2@zte.com.cn,
	rostedt@goodmis.org,
	si.hao@zte.com.cn,
	yang.yang29@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re:[PATCH  5.15-rt] printk: ignore that console preempted by irq/softirq.
Date: Thu, 23 May 2024 16:04:47 +0000
Message-Id: <20240523160447.740955-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523235401355RFqSAGtIPwMKV39mUulN1@zte.com.cn>
References: <20240523235401355RFqSAGtIPwMKV39mUulN1@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry, this is wrong subject. ignore this, it should have been to 5.10-rt
