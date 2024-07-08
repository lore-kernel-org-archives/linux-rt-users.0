Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8F51DDF4
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jul 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468264; cv=none; b=GLomfv5OhSFvyXGQHHjhyGDarJM/xRHCbUVjpCqxhleAQREkaPP4r2AhLPhVrv6ofyk1nDbhjG6mO9FWxYBOAusIRy1Uv9nIXiOJGlsX356trsP8QD8pUzsc/C3h20tQj0Bhwl/05q3kr/x9UzbyIeAIi/zr/g9jD9YwCpq9o6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468264; c=relaxed/simple;
	bh=Vb2KhEEgVKzfI2VIUrYt8Hh1TTfYL2m1uA9KqltkMl4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufwFtRr1To51q4Cn6keciKKJrv+Rq82xejOAuncj6ZajJR6W+8GdBidv3UqVE/eHzpIcNxHCQqFjeLigDIjqucy/c/33UM597CNSwVwK42zgtj3pX6RmmRB8l3gvQO0ONjKeWhXS8HIR1kKJz1pXMCBPuCogk/FeiI7iiMz2rXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvzMpN7p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvzMpN7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720468261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vb2KhEEgVKzfI2VIUrYt8Hh1TTfYL2m1uA9KqltkMl4=;
	b=dvzMpN7pbqpaK5S9iuA0QrhJcfzb1Be+ZvTZ2cTOVQbm9+HchF6FipsBkaoBuA7+BS/2Ql
	evLbKb82lofcRcneJPTkP4SL2aQ3eEtIygW/amu5rEkmZF5P3cXRg34qepHob2h2l0VDqN
	7JoUEuxZMp3kD4BwINQDEKbVD3wmlLo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-6Rk4p94uN0aTPXLTeQvtbg-1; Mon,
 08 Jul 2024 15:50:59 -0400
X-MC-Unique: 6Rk4p94uN0aTPXLTeQvtbg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 188E2196E08E
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jul 2024 19:50:59 +0000 (UTC)
Received: from [10.2.16.137] (unknown [10.2.16.137])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3C3019560AA;
	Mon,  8 Jul 2024 19:50:57 +0000 (UTC)
Message-ID: <f9e54c66a53132d6878c84c2c1c32506ecb9929e.camel@redhat.com>
Subject: Re: [PATCH] Updated rteval man page
From: Crystal Wood <crwood@redhat.com>
To: Anubhav Shelat <ashelat@redhat.com>, linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com, kcarcia@redhat.com
Date: Mon, 08 Jul 2024 14:50:56 -0500
In-Reply-To: <20240605182454.96479-1-ashelat@redhat.com>
References: <20240605182454.96479-1-ashelat@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, 2024-06-05 at 14:24 -0400, Anubhav Shelat wrote:

> =C2=A0
> -.SH MODULE OPTIONS
> +.SH CYCLICTEST OPTIONS
> =C2=A0These are options that affect the execution behavior of the measure=
ment
> and load modules.

Why is this section called "cyclictest options" when there are stressng
options in it?

-Crystal

