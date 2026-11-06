Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000616;
	b=QrqxaJxa7oYa8tbdOdqkkWOa2yx2856/0lIqWX3x9onwFXFwekkFIvXBULpQMdpR/oOR
	 ueA9AkI0z5QhlYrvvqUIZubGOXFFJgX3L/3DknP8J7B+87CBoCQXF1MSmKR0W0SUXsQJp
	 Lw12JvYDPz8lr8TlWIPTLl+CaJ5CLTiVcg15goTgfUIVn2k7zFQguBoQA976JF+pcPEGt
	 7I4rsPdEyIDxpY3ELBy3C0Ec7A3/btIrV1MqRQ0RAP/V9NRF/odHvGHmhjVjx/oBa6pKR
	 QzhRmpkxxqX5Fjz22/fitRYl40Vga/LQPJ0v+Hnsf16z/A9WDK9d1Vi6kVx5gK8C5GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=fVpPWmfC7LQIYam5qQvo3JLu/NjVNTLzQraft8aLJeM=;
	b=aE5yELElVi2EJ4E+ZkGa/R0ngQ/MdLcnzUkqLVwPmpgmWD6r7kGZsH//TMPddXaqrxiH
	 XjVZwqwwltSqCUc9PV8yH8OLitwIRjQcg5tLH8w41wik+YVvw6lIwqsls1hcqC6MZzqaV
	 8HAAhUo1k+2mmUXL7U74mOHftiq5wDY6UkJuNksjyEXZFYEk4neVHebCkMVj75oCtRwfu
	 y86FW04I0SIjqXl1/j4uvnpcGYYaZDXVlmRY1x1cct1vru0N8MiwhCMGp90AfuMzXBjGc
	 x9ZWK80scCBLb6Tfuqg+C7G5+8l8LI0AWQBsM1P/pu3CSAcDlpQ7NAzfP2uUhsx+IAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="nKy/LxHf";
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539FD606A330
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Nov 2026 21:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 539FD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nKy/LxHf
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91e7fc8265aso15112996d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Nov 2026 13:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794000615; x=1794605415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fVpPWmfC7LQIYam5qQvo3JLu/NjVNTLzQraft8aLJeM=;
        b=nKy/LxHfWeKvLZTiu6iKFUW9O+HkYeF31WFITe4hgJ5Gxyng9OlHzYZXg8di+Xawnt
         jO/JA//93SC+DbELGqpR+HxAeXoTztIUxK14Cm1XIenmmNsKqYAWlImlTEbhRSoMszq5
         aJBAviOxm7GstfplAfZeKkH98mIJ9Vo2Z5NQ1lkCC6yIuChj0O91B3b7yC5dK9/jTtHp
         WrIlsHfE6+c1VpbIjSnPy/6P4uxrX6uoyKicNHbRA/7TLssuZdnPH8XRHqcOVFvDDbnt
         uuf3RXXJT60vwKb8dK5pqY6ZmjZuyrSrUixiTES7dvB9jPXCcRkVWuP8PPWyhCg1zpqv
         qvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000615; x=1794605415;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fVpPWmfC7LQIYam5qQvo3JLu/NjVNTLzQraft8aLJeM=;
        b=vZtloFcu3ImLXx+LNAfPzNgAjWARsvNE/FRrnCESwu2ftk12JyTU2/F1vH5e2sguWo
         A/sm3P/BH85CI1FRA9RbO/ipqAt8s2UY67y2gnDexAfbqESwqj41IxvkfyB1Rn7z+R0h
         OM9ogD88epMeuKYuYflGG0d+N7je+z5M+y9bQnBnJ2YL9W5oH9A/JQPVj6qUfVf1YsHj
         JZQ4Kd0Rx1nceFHhhl5vAqM/FWwwlPTMYStd1PW561RYLerESh5cgUcwYu/nI+g/tIz5
         Oih+QqJAi0A8wOkcydjO1ufEbCxwEavokhlyq/Q9QWeqGYeOxOwkivg4riE6PnGzGtbF
         aP0A==
X-Gm-Message-State: APuU4Z9mvUrFix9hF+nkw5hfHVzzN91KKq4BxluqBEmidvc995B6jkdv
	xcCNgErY99z57Le2NbB7W3UPO0mWc9bncnu/7zH/oByBhebZM7MfpWJJCP/QGg==
X-Gm-Gg: AYBFou1W1QGm9dKxz4i37NA4SyQ9eDf1UOI6jRzG0lWr6e/c9OY5PTcXW9/R4De5MiV
	L7Zvxux1ieIMj1x8khxsD/fDeQKtjOfxDhaAPdE9K1nHTo/bov6pcsnX0iydfEVs/DAen879vPO
	e5ZCFqUaEE9W/x1EPFQRcJKr5Yi4KxqsTqDwLSXX1o7ntes38loXPHyNJgegZ2zT3neotj/B8EZ
	hDwsIWCBnfw3gPbEDmONMbNHI63Ski1smh+nG1ioivAGfNpmp2BAO2jU84ZYUhRWuZ9kPInd4QU
	CWNYW9Iu7cyLnzH472WOvqEBH1vOM6Xu/XIKHYOoJd+9HeX9wjGOM1ZOR1gs6ry3bmfR5UxMjro
	//s1WDdv2Pa8gAI8HyH5SQsK/aI2n37ZlyxG1gsnVhm6Gsiort0+1NEiDvOwvWqWg4gpUw4bryl
	NaavxAvrTkWW8JBDJb2xt5YYyqRGSIteMA6Tk4FTeuAPEbdW0FhkEiSlMntoNeTXozodswIwi+C
	xmtrLpe/dHE7pE1krv/MGL5DT6X+seMntNFC3i/Q5RrFlUE4hFMjB1o78u5P2kt1OYMFLgnshM9
	rK7pi63tWmK/cR2+8/bidi1DD+FEkJyWKZym6CoWIywXplO729udxQI2Xgxvt4Epb6X6xzP7STM
	8rNA828NauNOWZbC8VD7Ma4WumerYUuCyg5e6KEZ9BFI+1z9mEiaOxewPTQ==
X-Received: by 2002:ad4:5de2:0:b0:91b:5d39:e13d with SMTP id 6a1803df08f44-91ea98488b0mr57723266d6.50.1794000615086;
        Fri, 06 Nov 2026 13:30:15 -0800 (PST)
Received: from jkacur-thinkpadp1gen2.rmtcaon.csb ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6900b00sm29531346d6.4.2026.11.06.13.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:30:14 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Sana Sharma <sansshar@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3] rteval: Fixed hardcoded paths in class TestCpusetManagerCLIIntegration
Date: Fri,  6 Nov 2026 16:29:58 -0500
Message-ID: <20261106212958.123383-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <auzWo66c2JavzMBW@sansshar-thinkpadp1gen4i.boston.csb>
References: 
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 05 Nov 2026 at 14:18:59 -0500, Sana Sharma wrote:
> [PATCH v3] rteval: Fixed hardcoded paths in class TestCpusetManagerCLIIntegration

Applied, thanks!

Signed-off-by: John Kacur <jkacur@redhat.com>
