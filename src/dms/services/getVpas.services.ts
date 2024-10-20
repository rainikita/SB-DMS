import { Injectable, Inject } from '@nestjs/common';
import { VpasQueryService } from '../queries/get_vpas_queries';
import { Pool } from 'pg'; // Import Pool from 'pg'

@Injectable()
export class VpasService {
  constructor(
    @Inject('DATABASE_POOL') private readonly pool: Pool, 
    private readonly vpasQueryService: VpasQueryService,
  ) {}

  async getVpas() {
    const queryStr = await this.vpasQueryService.getVpas();
    const result = await this.pool.query(queryStr);
    return result.rows;
  }
}
