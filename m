Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443037A481
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264503; cv=none; b=FTH7rOj03+xRvgp5derP5P0pZ0IEJkX24rJw4T0umjVXJVq7W/zN7LeZ9RZrUbGGxyngtpbbz/wiwQq9cQh/r85+jgho4iQGkp/NIbVgXTT9MmLwlkp+yMjUKots5XHRoI/EIYCcNicB0UrofiKSOdPT/NZS+EKYs6ZCvSbMfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264503; c=relaxed/simple;
	bh=oQKwZF3s/xGduH73Xo4W4kmKzSsX2RJ3Rll7nqIpq6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRogPkuyccQYzbG2UFy2mHsmS0uTQgx3bqpSS3KyjnJxOGPLYFqB3h9LGo/jWHsVBxQeAErSXtl74PZOVO5uPmVUKw/eZLP1o2Zxekbemi5KAV5wUeWUhe4rtVRwrnUrCVIYqJd7LgSHM2MP2D1fYVqi+YvFXTZCmILzMBkd85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e09ILjGN; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e09ILjGN"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cfc5941028so992081185a.1
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264501; x=1776869301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQKwZF3s/xGduH73Xo4W4kmKzSsX2RJ3Rll7nqIpq6w=;
        b=e09ILjGNWHxOuCDtO30lxb92qjFfsimfnrD7vHc+PC0CZLwvXrftb8gIBSue2NCl1C
         xAyqQEocDt6x/tKOGl8D5Y601q3pajErggPk9GnGLA4g9feiSy+59/00jyCSlqebURje
         I5vAs/yD6vGMx+BwWc0RPTA0oG23CzyX7o+qTxbs+/6dseCtPbWP3lBRp2MWMDgzp4zi
         by8+HlzTftFiTRGD5khAtC/aUVPR/LTtFFc/nu3wvKCbmY9/QIUTD6kKxy0QepIQkr67
         NSqSGYKzBcpgwwDWYFr5U/BaACbpqAPSh7FNWnHUp1VLch18CCsDP0C7t09wJf5cseJx
         X6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264501; x=1776869301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQKwZF3s/xGduH73Xo4W4kmKzSsX2RJ3Rll7nqIpq6w=;
        b=BSvZCNXvFBHhxVVJdwLDnk/foVuZrDSAYxGuaTRopaOeSY4wpJ23ilf5MlDhNGIKFW
         /zgV+FHSTLzRzLz9AlkImW4fLuBPvszyWYKEOtvaKvFVdZzXNQRBPPMG9LMLex7i2nZX
         2t5AQdtS9iIvNH/IYNNfdqAjOitXtkTqsB8lD+nUuX6ZM7Lvbgo3/x2ItBQq/XDxFURo
         I4QTFSes+ZVSS+/qZgvvXqLvIx3i1fwKAnjEa3iwGdKCiwBw2TpYhaWfojesXDK2hgkk
         texxyVka/dfaRrbT6o8HWQFd/N3KLQYPviPfXkZLKSjlUDnJgXCSL91u7AHWpEFCBRwB
         ZDjA==
X-Gm-Message-State: AOJu0YwbxpHChQrJXO4ej1b7HucCnYSvS2en20KGz4jRJXSJ2mx69H4H
	DIqRNZm7XGSzavzxtO2bN2/VaXrDArH7vFvXelZvM/QCmxBfZ/gIuh0XJzPv6w==
X-Gm-Gg: AeBDieu2yBN41EN+MRUhR36Lrw9ovA/eq20CALb+aW7++9iwqyrAil47AMHvEbJmGaH
	eNG2tvW2JNALFYNQrV/dIZkMTeeqJLM1Co5tUQnZ5aZtBxU8UvNmsBeXo+I+G+8zpWZCL7YbsVz
	EO30bkVWSYeJEGrocvzfPbWnSaoEOqGbH16aqWDuJViy8UtPmBfD0EKiK4l0sBv9hR6PB9M3aqs
	gvbrF5BD8KOlswNbOd5JRpRpEYcuq6MNB+2asgo0L6qsPxHMFVkmZAbE0nc3pOu9U52UY+uIUWq
	jrL0USInhlN7uxAYP3ATAoAok6lFb9ymXzvjm/bZZW4pH5ljOic19XaqtbYA19sfBoIVGwZb0Nm
	earuGvJkM6XU0Tig8Z4WOM36DT8O0mOGxrE9ti/w7Oe8087pXJdGdznrZTyZUDgn75zrtGfaDNb
	Yz5ZSpskGWoYoS/wRQHP9w9MONeD0TWcwUtWPdOkPlzFFS7hN/Hv9Wo9zCKOydUkuPSZdW2RENy
	sSjsv4bTNqyJ9lCJiE=
X-Received: by 2002:a05:620a:4612:b0:8cd:b315:6af6 with SMTP id af79cd13be357-8ddcd4ff455mr3239166385a.8.1776264501143;
        Wed, 15 Apr 2026 07:48:21 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ec18f2b0sm134176585a.0.2026.04.15.07.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:48:20 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 5/6] cyclictest: Allow symbolic clock names
Date: Wed, 15 Apr 2026 10:48:06 -0400
Message-ID: <20260415144806.109829-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407-auxclocks-v1-5-1ef80d14eb0a@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Apr 2026 at 08:48:45AM +0200, Thomas Weißschuh (Schneider Electric) wrote:
> cyclictest: Allow symbolic clock names

Applied, thanks!

Signed-off-by: John Kacur <jkacur@redhat.com>
